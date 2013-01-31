class Api::V1::BusinessPinController < Api::V1::BaseController

  def update
    response = Business.api_pin_update(business_params, current_user)
    if response[:success].present?
      render json: { messages: ['Successfully updated your Master PIN'] }
    else
      render_api_response response
    end
  end

  private
  def business_params
    params.permit(:id, business: [:id, :master_pin])
  end

end