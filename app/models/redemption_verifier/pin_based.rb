module RedemptionVerifier
  class PinBased

    # payload: [
    #   pin_number: 1234
    #   user_prize: <#UserPrize Object Instance#>
    # ]

    class << self

      def verify_redemption?(payload)
        business = payload[:user_prize].prize.campaign.business
        payload[:pin_number].to_i == business.master_pin.to_i
      end

    end

  end
  
end