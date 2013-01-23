module ControllerMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
  def authenticate_with_token
    user = User.new
    controller.stub(:authenticate) { true }
    controller.stub(:current_user) { user }
  end
  module ClassMethods
  end
end