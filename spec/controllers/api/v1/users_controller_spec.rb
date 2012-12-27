require 'spec_helper'

describe Api::V1::UsersController do
  
  describe '#create' do

    describe "create/registration was successfull" do

      it "should render create.json.jbuilder view" do
        post :create, user: { :email => 'narang.jasdeep@gmail.com', :first_name => 'Jasdeep', :last_name => 'Narang'}, format: :json
        expect(response).to render_template("create")
      end

    end

  end

end