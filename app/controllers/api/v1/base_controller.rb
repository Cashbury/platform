class Api::V1::BaseController < ApplicationController
  before_filter :only_json_allowed

  rescue_from Exception do |exception|
    render json: { errors: [exception.message] }, status: :internal_server_error
  end

  def only_json_allowed
    raise Api::Exception::BadRequest unless request.format.json?
  end
end