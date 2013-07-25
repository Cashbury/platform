class Api::V1::PrizeBoardsController < Api::V1::BaseController

  def show
    @token = PlayToken.find(params[:id])
    @prize_board = current_user.prize_board(@token)
    render :show
  end

end