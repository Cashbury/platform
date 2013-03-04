require 'spec_helper'

describe Location do

  describe "#validations" do

    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :country }
    it { should validate_presence_of :state   }
    it { should validate_presence_of :postal_code }

  end

  let(:location) { {
    :is_mobile      => true,
    :name           => 'Toronto Location',
    :phone_number   => '900-900-9000',
    :description    => 'Some description about the location',
    :featured_image => 'http://cdn.cloudinary.com/image.jpg',
    :business_id    => 10,
    :street_address => '49 Avalanche Cres',
    :city           => 'Brampton',
    :state          => 'ON',
    :country        => 'Canada',
    :postal_code    => 'L6P 1L8'
    } 
  }

  describe "class methods" do

    describe ".api_create" do

      let(:user) { stub_model(User) }
      let(:param) { { location: location} }

      describe "error scenarios" do

        it "should raise error when business with the given ID does not exist" do
          Business.stub(:find).with(10) { raise ActiveRecord::RecordNotFound }
          
          response = Location.api_create(param, user)
          response.should == { errors: ['Business with provided business id does not exist'] }
          response[:success].should be_nil
        end

        it "should return error when the user does not own the business" do
          business = stub_model(Business, id: 10 )
          Business.stub(:find).with(10) { business }
          
          user.stub(:has_role?).with(:admin, business) { false }
          response = Location.api_create(param, user)
          response[:success].should be_nil
        end

      end

      describe "success scenarios" do

        it "should save and return a success key" do
          business = stub_model(Business, id: 10)
          Business.stub(:find).with(10) { business }
          user.stub(:has_role?).with(:admin, business) { true }
          
          response = Location.api_create(param, user)
          response[:success].should == :ok
          response[:object].should be_a(Location)
        end

      end

    end

  end

  describe "#full_address" do

    let(:location) { stub_model(Location, street_address: '4 Boake Street', city: 'Toronto', state: 'ON', country: 'Canada', postal_code: 'M3J0B6' )}

    it "should return the full address of the location" do
      location.full_address.should == '4 Boake Street, Toronto, ON, M3J0B6, Canada'  
    end

    it "should skip an address element if not present" do
      location.city = nil
      location.full_address.should == '4 Boake Street, ON, M3J0B6, Canada'
    end

  end

end