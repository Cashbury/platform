require 'spec_helper'

describe Api::V1::Marketing::CampaignsController do
  render_views

  before(:each) do
    authenticate_with_token
  end

  let(:user) { stub_model(User) }
  let(:campaign) { {
    :campaign_type_id  => 5,
    :name              => 'Spin2Win',
    :start_date        => Date.today,
    :end_date          => (Date.today + 10),
    :business_id       => 10
    } 
  }

  describe '#create' do

    it "should respond with a success status code and create template" do
      business = stub_model(Business, id: 10) 
      Business.stub(:find).with(10) { business }
      campaign_type = stub_model(CampaignType, id: 5) 
      CampaignType.stub(:find).with(5) { campaign_type }

      Marketing::Campaign.any_instance.stub(:business) { business }
      user.stub(:has_role?).with(:admin, business) { true }
      controller.stub(:current_user) { user }

      post :create, campaign: campaign, format: :json

      response.status.should == 200
      expect(response).to render_template("create")
    end

    it "should respond with a business not found if no business exists" do
      Business.stub(:find).with(10) { raise ActiveRecord::RecordNotFound }
      
      post :create, campaign: campaign, format: :json
      
      response.status.should == 422
      JSON.parse(response.body).should == { "errors" => ['Business with provided business id does not exist'] }
    end

    it "should respond with a campaign type not found if no campaign_type exists" do
      business = stub_model(Business, id: 10) 
      Business.stub(:find).with(10) { business }
      CampaignType.stub(:find).with(5) { raise ActiveRecord::RecordNotFound }
      
      post :create, campaign: campaign, format: :json
      
      response.status.should == 422
      JSON.parse(response.body).should == { "errors" => ['Campaign type with provided campaign type id does not exist'] }
    end


  end

end