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

  describe "#downcase_subdomain" do

    it "should downcase subdomain before saving" do
      business.subdomain = "JASDEEP"
      business.downcase_subdomain.should == "jasdeep"
    end

  end

  describe '#create_new_for(user)' do

    let(:user) { stub_model(User) }

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

end
