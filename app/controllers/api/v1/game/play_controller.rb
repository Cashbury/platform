class Api::V1::Game::PlayController < Api::V1::BaseController

  def create
    @game = Game.first
    @token = PlayToken.find(params[:token_id])
    @outcome = @game.play(@token)
    render :create
  end

end