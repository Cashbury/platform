json.business do |json|
  json.partial! 'api/v1/businesses/business', business: @business
  json.partial! 'api/v1/businesses/tokens', tokens: current_user.play_tokens(@business)
end