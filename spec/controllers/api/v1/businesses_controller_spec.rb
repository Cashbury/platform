require 'spec_helper'

describe Api::V1::BusinessesController do
  
  describe '#index' do
    it " should render all businesses" do 
      get :index, format: :json
      expect(response).to render_template('index')
    end
  end

  describe '#create' do

    let(:business) { { :name => 'Toast', :legal_name => 'Toast Inc.', :state => 'pending', :description => "Toast Inc. is serving the community from past 30 years"} }

    describe "create was successfull" do

      #pending status
      it "should render create.json.jbuilder view" do
        post :create, business: business, format: :json
        expect(response).to render_template("create")
      end

    end

    describe "create failed" do
      
      it "should render response with errors" do
        business[:name] = ''
        post :create, business: business, format: :json
        JSON.parse(response.body).should include('errors')
      end
    end

  end

end