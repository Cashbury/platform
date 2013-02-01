class Api::V1::CampaignsController < Api::V1::BaseController

  def create
  	response = Marketing::Campaign.api_create(params, current_user)
  	if response[:success].present?
  		@campaign = response[:object]
      render 'create'
  	else
  		render_api_response response
  	end
  end

  private
  def campaign_params
    params.require(:campaign).permit!
  end

end