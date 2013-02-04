class Api::V1::Marketing::PrizesController < Api::V1::BaseController

  def create
    response = Marketing::Prize.api_create(params, current_user)
    if response[:success].present?
      @prize = response[:object]
      render 'create'
    else
      render_api_response response
    end
  end

end