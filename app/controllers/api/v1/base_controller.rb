class Api::V1::BaseController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  before_filter :only_json_allowed

  rescue_from Exception do |exception|
    render json: { errors: [exception.message] }, status: :internal_server_error
  end

  def render_api_response(response)
    if response[:errors]
      render json: { errors: response[:errors] }, status: :unprocessable_entity
    else
      render json: { errors: 'Internal Server Error or Unknown Error' }, status: :internal_server_error
    end
  end

  def only_json_allowed
    raise "Api::Exception::BadRequest - Request format must be JSON" unless request.format.json?
  end

end