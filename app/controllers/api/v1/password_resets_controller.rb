class Api::V1::PasswordResetsController < Api::V1::BaseController

  skip_before_filter :authenticate

  def create
    @user = User.find_by_email(params[:email])
    if @user.present?
      # @user.deliver_reset_password_instructions!
      PasswordResetWorker.perform_async(@user.id)
      @message = 'A password reset instructions email has been sent at the email address you provided'
    else
      render_api_response( { :errors => ['We were unable to find a user with that email address.'] } )
    end
  end

end