require 'spec_helper'

describe Api::V1::EngagementController do

  before(:each) do
    authenticate_with_token
  end

  it "should be routable" do
    pending
  end

  context "when spend/transaction node is present" do
    let(:spend) { {
        :amount => 10.23,
        :business_id => 2,
      } 
    }
    let(:user)      { stub_model(User) }
    let(:business)  { stub_model(Business, id: 2) }

    before(:each) do
      Business.stub(:find) { business }
      user.stub_chain(:marketing_money_accounts, :for_business, :first) { stub_model(Account::MarketingMoney, balance: 100.00, save: true) }
      controller.stub(:current_user) { user }
    end

    it "should reduce the user balance by that amount" do
      post :create, engagements: { spend: spend }, format: :json
      response.status.should == 200
    end

    it "should not reduce the balance if user doesn't have enough money" do
      pending
    end

    it "should not reduce the balance if the amount is negative" do
      pending
    end

  end

end