json.business do
  json.name @business.name
  json.image @business.logo
end

json.marketing_account do
  json.amount_spent params['engagements']['spend']['amount']
  json.balance @account.balance.to_f
end

json.issue_play_tokens do 
  json.tokens_earned params['engagements']['issue_play_tokens']['count']
  json.tokens_balance current_user.play_tokens.for_business(@business).count
end