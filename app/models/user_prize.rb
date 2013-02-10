class UserPrize < ActiveRecord::Base
  self.table_name = 'user_prizes'

  belongs_to :user
  belongs_to :prize, class_name: 'Marketing::Prize'

  state_machine :state, :initial => :unlocked do
    
    event :redeem do
      transition :unlocked => :redeemed
    end

  end

end