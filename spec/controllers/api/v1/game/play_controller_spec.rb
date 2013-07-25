require 'spec_helper'

describe Api::V1::Game::PlayController do 

  describe "#play" do

    it "should play the token" do
      post :create, token_id: 22, format: :json
      response.status.should == 200
    end

  end

end