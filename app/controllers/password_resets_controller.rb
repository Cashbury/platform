class PasswordResetsController < ApplicationController

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
  end

  def update
    @token = params[:reset_token]
    @user = User.load_from_reset_password_token(params[:reset_token])
    not_authenticated unless @user
    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      redirect_to(root_path, :notice => 'Password was successfully updated.')
    else
      render :action => "edit"
    end
  end

end