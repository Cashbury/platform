require 'spec_helper'

describe UserPrize do

  let(:user) { stub_model(User) }
  let(:prize){ stub_model(Marketing::Prize) }
  
  it { UserPrize.table_name.should == 'user_prizes' }
    
  describe "state machine" do

    describe "#redeem" do

      it "should change the user prize state to redeemed" do
        # prize.stub(:prizeable) { stub_model(Prize::MarketingMoney, quantity_available: 10) }
        # prize.unlock_for(user)
        # user.user_prizes.first.redeemed?.should be_true        
      end

    end

  end
end