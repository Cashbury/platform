require 'spec_helper'

describe Api::V1::BusinessPinController do 

  render_views

  before(:each) do
    authenticate_with_token
  end

  describe "update" do
  
    let(:user)     { stub_model(User) }
    let(:business) { stub_model(Business, id: 10) }

    it "should update the business PIN if business exists and user owns it" do
      Business.stub(:find) { business }
      user.stub(:has_role?) { true }
      Business.any_instance.stub(:update_attributes) { true }
      controller.stub(:current_user) { user }

      put :update, id: 10, business: { id: 10, master_pin: '1234' }, format: :json

      response.status.should == 200
      JSON.parse(response.body).should == { "messages" => ['Successfully updated your Master PIN'] }
    end

    it "should raise an error if the user does not own the business" do
      user.stub(:has_role?).with(:admin, business) { false }
      Business.stub(:find) { business }

      put :update, id: 10, business: { id: 10, master_pin: '1234' }, format: :json

      response.status.should == 422
      JSON.parse(response.body).should == { "errors" => ['User is not authorized to update PIN for this business'] }
    end

    it "should raise an error if the business does not exist" do
      Business.stub(:find) { raise ActiveRecord::RecordNotFound }
      Business.any_instance.stub(:update_attributes) { false }

      put :update, id: 10, business: { id: 10, master_pin: '1234' }, format: :json

      response.status.should == 422
      JSON.parse(response.body).should == { "errors" => ['The business does not exist'] }
    end

  end



end