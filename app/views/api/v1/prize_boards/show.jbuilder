json.prize_board(@prize_board.paylines) do |json, payline|
  
  json.id    payline.id
  json.group payline.group
  json.icon1 payline.icon1.internal_name
  json.icon2 payline.icon2.internal_name
  json.icon3 payline.icon3.internal_name

  if payline.group == 'business'
    json.prize payline.prize_for(@token.business)
  elsif payline.group == 'national'
    json.prize Marketing::Prize.where(group: 'national', payline_id: payline.id).first
  end

end