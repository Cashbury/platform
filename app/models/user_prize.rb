class UserPrize < ActiveRecord::Base
  self.table_name = 'user_prizes'

  belongs_to :user
  belongs_to :prize, class_name: 'Marketing::Prize'

  state_machine :state, :initial => :unlocked do
    
    before_transition any => [:redeemed, :deposited] do |user_prize, transition|
      user_prize.verify_redemption?(transition.args.first) ? true : false
    end

    after_transition any => [:redeemed, :deposited] do |user_prize, transition|
      user_prize.trigger_redeemed_logic
    end

    event :redeem do
      transition :unlocked => :deposited, :if => lambda { |user_prize| user_prize.prize.prizeable.is_a?(Prize::MarketingMoney) }
      transition :unlocked => :redeemed,  :if => lambda { |user_prize| user_prize.prize.prizeable.is_a?(Prize::Item)           }
    end

  end

  def verify_redemption?(payload)
    payload ||= {}
    payload.merge!(:user_prize => self)
    "redemption_verifier/#{redemption_method}".classify.constantize.verify_redemption?(payload)
  end

  def redemption_method
    # Add tests
    prize.redemption_method
  end
  
  def trigger_redeemed_logic
    case prize.prizeable
    when Prize::MarketingMoney
      user.marketing_money_accounts.first.load(prize.prizeable.value)
    end
  end

end