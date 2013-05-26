require 'spec_helper'

describe Game::Icon do
  
  describe "validations" do

    it { should validate_uniqueness_of(:internal_name).scoped_to(:game_id) }

  end

end
