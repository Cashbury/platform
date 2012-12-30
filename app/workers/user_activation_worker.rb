class UserActivationWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    UserMailer.activation_needed(user).deliver
  end
end