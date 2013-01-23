require 'spec_helper'

describe Api::V1::PasswordResetsController do
  render_views

  describe "#create" do

    let(:user) { stub_model(User, :email => 'narang.jasdeep@gmail.com') }

    describe "when user with email exists" do
      
      before(:each) do
        User.stub(:find_by_email).with('narang.jasdeep@gmail.com') { user }
      end

      it "should generate a user password reset token" do
        post :create, email: 'narang.jasdeep@gmail.com', format: :json
        response.status.should == 200
      end

      it "should render a positive message" do
        post :create, email: 'narang.jasdeep@gmail.com', format: :json
        JSON.parse(response.body).should include("message")
      end

      it "should hand over the email and reset job to the worker" do
        PasswordResetWorker.should_receive(:perform_async).with(user.id)
        post :create, email: 'narang.jasdeep@gmail.com', format: :json
      end

    end

    describe "when user with email does not exist" do
      before(:each) do
        User.stub(:find_by_email).with('narang.jasdeep@gmail.com') { nil }
      end

      it "should generate a user password reset token" do
        post :create, email: 'narang.jasdeep@gmail.com', format: :json
        response.status.should == 422
      end

      it "should render a positive message" do
        post :create, email: 'narang.jasdeep@gmail.com', format: :json
        JSON.parse(response.body).should include("errors")
      end
    end

  end

end