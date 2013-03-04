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

  def index
    latitude = params[:latitude].to_f
    longitude = params[:longitude].to_f
    radius = params[:radius].to_f
    @locations = Location.near([latitude, longitude], radius)
    if @locations.present?
      render :index
    else
      render json: { errors: "No nearby location." }, status: :unprocessable_entity
    end
  end

end