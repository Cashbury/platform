class UserPrize < ActiveRecord::Base
  self.table_name = 'user_prizes'

  belongs_to :user
  belongs_to :prize, class_name: 'Marketing::Prize'

end