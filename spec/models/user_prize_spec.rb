require 'spec_helper'

class SomeMethod
  def self.verify_redemption?
    
  end
end

describe UserPrize do

  let(:user) { stub_model(User) }
  let(:prize){ stub_model(Marketing::Prize) }
  let(:user_prize) { stub_model(UserPrize) }

  it { UserPrize.table_name.should == 'user_prizes' }

  before(:each) do
    prize.stub(:prizeable) { stub_model(Prize::Item, quantity_available: 10) }
    user.stub(:user_prize) { user_prize }
    user_prize.stub(:prize) { prize }
    user_prize.stub(:user)  { user  }
    user_prize.stub(:redemption_method) { 'pin_based' }
    RedemptionVerifier::PinBased.stub(:verify_redemption?) { true }
  end

  describe "state machine" do

    describe "#redeem" do

      it "should change the state from unlocked to deposited if it's marketing money" do
        user.stub(:marketing_money_accounts) { [stub_model(Account::MarketingMoney)] }
        user_prize.stub_chain(:prize, :prizeable) { stub_model(Prize::MarketingMoney, value: 80) }
        user_prize.redeem
        user_prize.deposited?.should be_true
      end

      it "should change the state from unlocked to redeemed if prize is item" do
        user_prize.stub_chain(:prize, :prizeable) { stub_model(Prize::Item) }
        user_prize.redeem
        user_prize.redeemed?.should be_true
      end

      it "should call the concerned redemption adapter" do
        user_prize.should_receive :verify_redemption?
        user_prize.redeem
      end

    end

  end

  describe "verify_redemption?" do

    it "should call the concerned redemption verification adapter" do
      RedemptionVerifier::PinBased.should_receive(:verify_redemption?)
      user_prize.redeem({ :pin_number => 9090 })
    end

  end

  describe "redemption_method" do

    it "should return the redemption_method value from prizeable" do
      user_prize.redemption_method.should == 'pin_based'
    end

    it "should read the value from the association" do
      #prize.should_receive(:redemption_method)
      #user_prize.redemption_method
    end

  end

end