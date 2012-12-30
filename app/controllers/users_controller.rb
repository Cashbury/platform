class UsersController < ApplicationController

  def activate
    if (@user = User.load_from_activation_token(params[:id]))
      @user.activate!
      redirect_to(:root_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end
end