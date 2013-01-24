class User < ActiveRecord::Base
  rolify

  authenticates_with_sorcery!
  attr_accessor :password, :password_confirmation
  
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  before_create :reset_authentication_token!

  has_many :marketing_money_accounts, class_name: 'Account::MarketingMoney', foreign_key: 'owner_id'
  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates_presence_of :email
  validates :email, uniqueness: true, email: true

  validates :password,    presence: true, length: { minimum: 6, maximum: 32 }, :on => :create
  validates :first_name,  presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name,   presence: true, length: { minimum: 2, maximum: 30 }

  def reset_authentication_token!
    self.authentication_token = SecureRandom.hex(24)
  end

end