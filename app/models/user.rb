class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body

  validates_presence_of :email
  validates :email, uniqueness: true, email: true
  validates :first_name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 2, maximum: 30 }

end