class User < ActiveRecord::Base
  rolify

  authenticates_with_sorcery!
  attr_accessor :password, :password_confirmation
  
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  before_create :reset_authentication_token!
  after_save    :notify

  has_many :marketing_money_accounts, class_name: 'Account::MarketingMoney', foreign_key: 'owner_id'
  has_many :authentications, :dependent => :destroy
  has_many :user_prizes
  has_many :prizes, through: :user_prizes
  has_many :play_tokens
  accepts_nested_attributes_for :authentications

  validates_presence_of :email
  validates :email, uniqueness: true, email: true

  validates :password,    presence: true, length: { minimum: 6, maximum: 32 }, :on => :create
  validates :first_name,  presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name,   presence: true, length: { minimum: 2, maximum: 30 }

  def reset_authentication_token!
    self.authentication_token = SecureRandom.hex(24)
  end

  def award_tokens(count, business)
    count.to_i.times { play_tokens.build(business_id: business.id ) }
    self.save
  end

  def marketing_money_balance_at(business)
    if marketing_money_accounts.present?
      marketing_money_accounts.for_business(business).first.balance.to_f
    else
      0.00
    end
  end

  # NOT TESTED!!!
  def play_token_balance_at(business)
    play_tokens.for_business(business).count
  end

  def notify
    ActiveSupport::Notifications.instrument("cashbury.user.registration", :dispatcher => self )
  end

end