class UsersController < ApplicationController

  def activate
    if (@user = User.load_from_activation_token(params[:token]))
      @user.activate!
      redirect_to(:root, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  def edit
  end

end