json.locations @locations do |location|
  json.id             location.id
  json.name           location.name
  json.latitude       location.latitude
  json.longitude      location.longitude
  json.street_address location.street_address
  json.city           location.city
  json.state          location.state
  json.country        location.country
  json.postal_code    location.postal_code
  json.full_address   location.full_address

  json.business do
    json.name  location.business.name
    json.logo           location.business.logo
    json.description    location.description
    json.pin_number     location.business.master_pin
    json.token_balance  current_user.play_token_balance_at(location.business)
    json.marketing_money_balance current_user.marketing_money_balance_at(location.business)
  end

  json.prizes location.business.prizes do |prize|
    json.id                 prize.id
    json.name               prize.name
    json.value              prize.prizeable.value
    json.description        prize.prizeable.description
    json.quantity_available prize.prizeable.quantity_available
    json.redemption_method  prize.prizeable.redemption_method
  end

end