class UserMailer < ActionMailer::Base
  
  default :from => "no-reply@cashbury.com"

  def activation_needed(user)
    @user = user
    mail(:to => user.email, :subject => "Activation Required | Cashbury")
  end

  def activation_success(user)
    @user = user
    mail(:to => user.email, :subject => "Welcome to Cashbury | Successful Activation")
  end

end