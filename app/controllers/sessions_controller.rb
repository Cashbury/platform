class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    user = params[:session]
    @user = login(user[:email], user[:password])
    if @user
      render 'create'
    else
      render json: { :errors => ['Authentication Failed: Check username/password or Account may not be active'] }, status: 401
    end
  end

  def destroy
    @user = User.find_by_authentication_token(params[:authentication_token])
    if @user
      render 'destroy'
    else
      render json: { :errors => 'Unable to sign out'}, status: 401
    end
  end

end