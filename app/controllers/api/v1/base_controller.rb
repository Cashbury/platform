class Api::V1::BaseController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  before_filter :only_json_allowed, :authenticate

  rescue_from Exception do |exception|
    render json: { errors: [exception.message, exception.backtrace] }, status: :internal_server_error
  end

  rescue_from Api::Exception::Unauthorized, with: :unauthorized
  rescue_from Api::Exception::BadRequest,   with: :bad_request
  rescue_from Api::Exception::Forbidden,    with: :forbidden

  helper_method :current_user

  def current_user
    @current_user
  end

  def render_api_response(response)
    if response[:errors].present?
      render json: { errors: response[:errors] }, status: :unprocessable_entity
    else
      render json: { errors: 'Internal Server Error or Unknown Error' }, status: :internal_server_error
    end
  end

  def only_json_allowed
    raise Api::Exception::BadRequest unless request.format.json?
  end

  protected

  def authenticate
    raise Api::Exception::Unauthorized if request.authorization.nil?
    authenticate_or_request_with_http_token do |token, options|
      user_exists = User.exists?(authentication_token: token)
      if !user_exists
        raise Api::Exception::Unauthorized
      else
        @current_user = User.find_by_authentication_token(token)
      end
    end
  end

  def unauthorized
    render json: { errors: ['Authentication Failed: Invalid Token'] }, status: :unauthorized
  end

  def forbidden
    render nothing: true, status: :forbidden
  end

  def bad_request
    render json: { errors: ['Request format can only be JSON.']}, status: :bad_request
  end

  def not_found
    render nothing: true, status: :not_found
  end

end