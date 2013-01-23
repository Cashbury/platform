require 'spec_helper'

describe Api::V1::LocationsController do
  render_views

  before(:each) do
    authenticate_with_token
  end

  let(:user) { stub_model(User) }
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

  describe '#create' do

    it "should respond with a success status code and create template" do
      business = stub_model(Business, id: 10)
      Location.any_instance.stub(:business) { business }
      Business.stub(:find).with(10) { business }
      user.stub(:has_role?).with(:admin, business) { true }
      controller.stub(:current_user) { user }

      post :create, location: location, format: :json

      response.status.should == 200
      expect(response).to render_template("create")
    end

    it "should respond with a business not found if no business exists" do
      Business.stub(:find).with(10) { raise ActiveRecord::RecordNotFound }
      
      post :create, location: location, format: :json
      
      response.status.should == 422
      JSON.parse(response.body).should == { "errors" => ['Business with provided business id does not exist'] }
    end

    it "should raise an error if the user does not own the business" do
      business = stub_model(Business, id: 10)
      Business.stub(:find).with(10) { business }
      user.stub(:has_role?).with(:admin, business) { false }
      
      post :create, location: location, format: :json
      
      response.status.should == 422
      JSON.parse(response.body).should == { "errors" => ['You are not authorized to make updates for the requested business'] }
    end

  end

end