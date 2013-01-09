require 'spec_helper'

describe SessionsController do
  render_views 

  describe "#create" do

    let(:authenticated_user) { stub_model(User, email: 'email@domain.com', authentication_token: 'someauthenticationtoken' ) }
    let(:user) { { :email => 'email@domain.com', :password => 'somepassword'} }

    describe "authentication successful" do
      
      it "should return users token" do
        @controller.stub(:login) { authenticated_user }
        post :create, user: user, format: :json
        assigns(:user).should_not be_nil
        JSON.parse(response.body).should include('authentication_token')
        JSON.parse(response.body)['authentication_token'].should == 'someauthenticationtoken'
      end

    end

    describe "authentication failed" do

      it "should return error that authentication failed" do
        @controller.stub(:login) { nil }
        post :create, user: user, format: :json
        JSON.parse(response.body).should include('errors')
        JSON.parse(response.body)['errors'].should == ['Authentication Failed']
      end

    end

  end

  describe "#destroy" do

    describe "should reset the users token" do

    end

  end

end