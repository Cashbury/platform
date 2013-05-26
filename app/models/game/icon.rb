class Game::Icon < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :game
  validates :internal_name, uniqueness: { scope: :game_id }

end
