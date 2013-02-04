class Api::V1::Marketing::CampaignsController < Api::V1::BaseController

  def create
  	response = Marketing::Campaign.api_create(params, current_user)
  	if response[:success].present?
  		@campaign = response[:object]
      render 'create'
  	else
  		render_api_response response
  	end
  end

end