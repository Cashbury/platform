class Api::V1::EngagementController < Api::V1::BaseController

  def create
    spend = params["engagements"]["spend"]
    play_tokens = params["engagements"]["issue_play_tokens"]
    if spend.present?
      @business = Business.find(spend["business_id"])
      @account = current_user.marketing_money_accounts.for_business(@business).first
      response = @account.api_spend(spend["amount"])
    end

    if play_tokens.present?
      @business = Business.find(play_tokens['business_id'])
      response2 = current_user.award_tokens(play_tokens["count"], @business)
    end

    if response[:success].present?
      render 'create'
    else
      render_api_response response
    end
  end
  
end