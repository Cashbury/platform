class PlayToken < ActiveRecord::Base

  belongs_to :user
  belongs_to :business

  scope :for_business, lambda { |business| 
    where(:business_id => business.id)
  }

  state_machine :state, :initial => :unplayed do
    
    event :play do
      transition :unplayed => :played
    end
    
  end

end