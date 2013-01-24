require 'spec_helper'

describe Business do
  
  describe 'validations' do
    it { should validate_presence_of(:legal_name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
    it { should ensure_length_of(:legal_name).is_at_least(2).is_at_most(50)}
    it { should ensure_length_of(:name).is_at_least(2).is_at_most(50) }
    it { should ensure_length_of(:subdomain).is_at_least(3).is_at_most(16) }
    it { should validate_format_of(:master_pin).with(1234) }
    it { should validate_numericality_of(:master_pin).only_integer }
    it { should ensure_length_of(:master_pin).is_equal_to(4) }
  end

  describe 'valid values' do
  	it { should allow_value('Starbucks Canada Inc.').for(:legal_name) }
  	it { should allow_value('Starbucks').for(:name) }
  	it { should allow_value('Starbucks is good coffee place').for(:description) }
    it { should allow_value('jasdeep').for(:subdomain) }
    it { should_not allow_value('jasdeep singh').for(:subdomain) }
    it { should_not allow_value('jasdeep @').for(:subdomain) }
    it { should_not allow_value('jasdeep!@#$%').for(:subdomain) }
    it { should_not allow_value('.com').for(:subdomain) }
    it { should_not allow_value('co').for(:subdomain) }
    it { should_not allow_value('12345678901234567').for(:subdomain) }
    it { should_not allow_value('12345').for(:master_pin) }
    it { should allow_value('1234').for(:master_pin) }
  end
  
  let(:business) { stub_model(Business) }
  let(:user) { stub_model(User) }

  describe "#downcase_subdomain" do

    it "should downcase subdomain before saving" do
      business.subdomain = "JASDEEP"
      business.downcase_subdomain.should == "jasdeep"
    end

  end

  describe '#create_new_for(user)' do

    before(:each) do
      business.subdomain = 'starbucks'
      business.stub(:save) { true }
    end

    it "should add admin role for user on the business" do
      user.should_receive(:add_role).with(:admin, business)
      business.create_new_for(user)
    end

    it "should setup the postgres schema for this business" do
      pending 'need to figure out how to test this'
    end

  end

  describe "class methods" do

    describe ".api_pin_update" do

      let(:params) { { business: { master_pin: 1234 } } }

      it "should return error when there is no business" do
        response = Business.api_pin_update(params, user)
        
        response[:errors].should_not be_nil
        response[:errors].should == ['The business does not exist']
        response[:success].should be_nil
      end

      it "should return error when user does not own the business" do
        business = stub_model(Business)
        Business.stub(:find) { business }
        user.stub(:has_role?).with(:admin, business) { false }

        response = Business.api_pin_update(params, user)
        
        response[:errors].should_not be_nil
        response[:errors].should == ['User is not authorized to update PIN for this business']
        response[:success].should be_nil
      end

      it "should return success when pin has been updated" do
        business = stub_model(Business)
        Business.stub(:find) { business }
        Business.any_instance.stub(:update_attributes) { true }
        user.stub(:has_role?).with(:admin, business) { true }

        response = Business.api_pin_update(params, user)
        response[:success].should_not be_nil
        response[:errors].should be_nil
      end

    end

  end

end
