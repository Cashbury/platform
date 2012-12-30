class UserMailer < ActionMailer::Base
  
  default :from => "no-reply@cashbury.com"

  def activation_needed(user)
    @user = user
    mail(:to => user.email, :subject => "Activation Required | Cashbury")
  end
end