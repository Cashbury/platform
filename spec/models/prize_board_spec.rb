require 'spec_helper'

describe PrizeBoard do

  let(:token)       { stub_model(PlayToken)}
  let(:prize_board) { PrizeBoard.new(token) }

  describe "#load_national_paylines" do

    it "should load the national paylines" do
      Game::Payline.should_receive(:national)
      prize_board.load_national_paylines
    end

  end

  describe "#load_business_paylines" do

  end

end
