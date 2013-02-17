require 'spec_helper'

describe Api::V1::UsersController do
  render_views
  
  describe '#create' do

    let(:user) { { :email => 'narang.jasdeep@gmail.com', :password => 'something', :first_name => 'Jasdeep', :last_name => 'Narang'} }

    describe "create/registration was successfull" do
      
      before(:each) do
        User.any_instance.stub(:save)   { true }
        User.any_instance.stub(:valid?) { true }
      end

      it "should render create.jbuilder view" do
        post :create, user: user, format: :json
        puts "If this fails - chances are Redis dependency is down."
        response.should be_successful
        response.should render_template("create")
      end

      it "should save the user if it is valid" do
        post :create, user: user, format: :json
        assigns(:user).should be_valid
      end

      it "should call the email worker" do
        UserActivationWorker.should_receive(:perform_async)
        post :create, user: user, format: :json
      end

    end

    describe "create/registration failed" do
      
      before(:each) do
        User.any_instance.stub(:save)   { false }
        User.any_instance.stub(:valid?) { false }
      end

      it "should render an error" do
        user[:email] = nil
        post :create, user: user, format: :json
        JSON.parse(response.body).should include('errors')
      end

      it "should not call the email worker" do
        UserActivationWorker.should_not_receive(:perform_async)
        post :create, user: user, format: :json
      end

    end

  end

end