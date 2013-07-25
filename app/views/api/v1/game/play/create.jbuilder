json.outcome do |json|
  json.index        @outcome[:index]
  json.win          @outcome[:win]
  json.result       @outcome[:result]
  json.payline_id   @outcome[:payline_id]
end