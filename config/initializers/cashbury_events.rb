ActiveSupport::Notifications.subscribe 'cashbury.user.registration' do |name, start, finish, id, payload|
  Event.create!(name: name, start: start, finish: finish, dispatcher: payload[:dispatcher], receiver: payload[:receiver], payload: payload)
end