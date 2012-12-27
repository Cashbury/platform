class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessor :password

  validates_presence_of :email
  validates :email, uniqueness: true, email: true

  validates :password, presence: true, length: { minimum: 6, maximum: 32 }
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }

end