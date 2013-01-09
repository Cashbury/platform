class User < ActiveRecord::Base
  rolify
  authenticates_with_sorcery!
  attr_accessor :password
  
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications

  validates_presence_of :email
  validates :email, uniqueness: true, email: true

  validates :password, presence: true, length: { minimum: 6, maximum: 32 }, :on => :create
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }

  def reset_authentication_token!
    self.authentication_token = SecureRandom.hex(24)
    self.save
  end

end