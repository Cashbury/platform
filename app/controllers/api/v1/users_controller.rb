class Api::V1::UsersController < Api::V1::BaseController

  skip_before_filter :authenticate

  def create
    @user = User.new(params[:user])
    if @user.save
      UserActivationWorker.perform_async(@user.id)
      render :action => 'create'
    else
      render_api_response( { :errors => @user.errors.full_messages } )
    end
  end

end