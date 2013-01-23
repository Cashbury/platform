require 'spec_helper'

describe Api::V1::BusinessesController do
  
  before(:each) do
    authenticate_with_token
  end

  describe '#create' do

    let(:business) { { :name => 'Toast', 
                       :master_pin => 9999,
                       :subdomain => 'toast', 
                       :legal_name => 'Toast Inc.', 
                       :state => 'pending', 
                       :description => "Toast Inc. is serving the community from past 30 years" } }

    describe "create was successfull" do

      #pending status
      it "should render create.json.jbuilder view" do
        Business.destroy_all
        post :create, business: business, format: :json
        
        response.status.should == 200
        expect(response).to render_template("create")
      end

    end

    describe "create failed" do
      
      it "should render response with errors" do
        business[:name] = ''
        post :create, business: business, format: :json
        JSON.parse(response.body).should include('errors')
        JSON.parse(response.body)['errors'].should include('Name can\'t be blank')
      end
    end

  end

end