class SessionsController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    user = params[:user]
    @user = login(user[:email], user[:password])
    if @user
      render 'create'
    else
      render json: { :errors => ['Authentication Failed'] }
    end
  end

  def destroy
    
  end

end