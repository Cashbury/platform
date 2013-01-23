class Api::V1::LocationsController < Api::V1::BaseController

  def create
    response = Location.api_create(params, current_user)
    if response[:success].present?
      @location = response[:object]
      render 'create'
    else
      render_api_response response
    end
  end

end