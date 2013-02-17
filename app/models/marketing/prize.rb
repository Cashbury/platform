class Marketing::Prize < ActiveRecord::Base
  self.table_name = 'marketing_prizes'

  validates :name, :presence => true
  belongs_to :prizeable, :polymorphic => true
  belongs_to :campaign, class_name: 'Marketing::Campaign'
  has_one :business, through: :campaign
  has_many :user_prizes
  has_many :users, through: :user_prizes

  class << self

    def api_create(params, user)
      return {:errors => 'Campaign ID must be provided'} if params[:prize][:campaign_id].blank?
      
      prizeable_type = params[:prize].delete(:prizeable_type)
      campaign_id    = params[:prize].delete(:campaign_id)
      prizeable      = prizeable_type.constantize.new(params[:prize])
      prize          = Marketing::Prize.new(name: prizeable.prize_name, prizeable: prizeable, campaign_id: campaign_id )
      
      if prize.valid? && prize.prizeable.valid?
        prize.save
        { success: :ok, object: prizeable }
      else
        prize.prizeable.valid?
        { errors: prize.prizeable.errors.full_messages }
      end
    end

  end

  def unlock_for(user)
    transaction do
      self.prizeable.decrement_quantity
      user.prizes << self
    end
  end

  def redemption_method
    prizeable.redemption_method
  end

end