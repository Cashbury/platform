class Marketing::Campaign < ActiveRecord::Base
	self.table_name = 'marketing_campaigns'

  belongs_to :business
  has_one :campaign_type
  has_many :prizes, :class_name => 'Marketing::Prize'

  validates :name, :presence => true
  validates :campaign_type_id, :presence => true

  class << self

    def api_create(params, user)
      business = Business.find(params[:campaign][:business_id]) rescue nil
      campaign = CampaignType.find(params[:campaign][:campaign_type_id]) rescue nil
      return { :errors => ['Business with provided business id does not exist'] } if business.blank?
      return { :errors => ['Campaign type with provided campaign type id does not exist'] } if campaign.blank?
      return { :errors => ['You are not authorized to make updates for the requested business']} unless user.has_role?(:admin, business)

      campaign = business.campaigns.build(params[:campaign])

      if campaign.save
        { success: :ok, object: campaign }
      else
        { errors: campaign.errors.full_messages }
      end
    end

  end

end
