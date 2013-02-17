class Api::V1::UserPrizesController < Api::V1::BaseController

  def redeem
    @user_prize = current_user.user_prizes.find(params[:id])
    response = @user_prize.redeem(params[:verification_attributes])
    if response
      render 'redeem'
    else
      render_api_response({ :errors => @user_prize.errors.full_messages })
    end
  end

end