require 'spec_helper'

describe Marketing::Campaign do

  let(:campaign) { {
    :campaign_type_id  => 5,
    :name              => 'Spin2Win',
    :start_date        => Date.today,
    :start_date        => (Date.today + 10),
    :business_id       => 10
    } 
  }
  let(:param) { { campaign: campaign} }
  let(:user) { stub_model(User) }
  let(:campaign_type) { stub_model(CampaignType) }
	
  describe 'validations' do
    it {should validate_presence_of :name }
    it {should validate_presence_of :campaign_type_id }
    it "should use the right table_name" do
      Marketing::Campaign.table_name.should == 'marketing_campaigns'
    end
  end

  describe "class_methods" do
    
    describe '#api_create' do

        it "should raise error when business with the given ID does not exist" do
          Business.stub(:find).with(10) { raise ActiveRecord::RecordNotFound }

          response = Marketing::Campaign.api_create(param, user)
          response.should == { errors: ['Business with provided business id does not exist'] }
          response[:success].should be_nil
        end

        it "should return an error when user does not own the business" do
          business = stub_model(Business, id: 10)
          Business.stub(:find).with(10) { business }
          
          user.stub(:has_role?).with(:admin, business) { false }
          response = Marketing::Campaign.api_create(param, user)
          response[:success].should be_nil
        end

        it "should return an error when campaign_type doesn't exist" do
          business = stub_model(Business, id: 10)
          Business.stub(:find).with(10) { business }
          CampaignType.stub(:find).with(5) { raise ActiveRecord::RecordNotFound }
          
          response = Marketing::Campaign.api_create(param, user)
          response.should == {errors: ['Campaign type with provided campaign type id does not exist'] }
          response[:success].should be_nil
        end

        it "should return success when all params are correct" do
          business = stub_model(Business, id: 10)
          Business.stub(:find).with(10) { business }
          campaign_type = stub_model(CampaignType, id:5 )
          CampaignType.stub(:find).with(5) { campaign_type }
          user.stub(:has_role?).with(:admin, business) { true }

          response = Marketing::Campaign.api_create(param, user)
          response[:object].should be_an_instance_of(Marketing::Campaign)
          response[:success].should_not be_nil
        end
    
    end
  end

end