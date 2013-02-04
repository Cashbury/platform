require 'spec_helper'

describe Api::V1::Marketing::PrizesController do

  render_views

  before(:each) do
    authenticate_with_token
  end

  let(:user) { stub_model(User) }
  let(:prize) { {
    :prize_name         => 'iPad 4 64 GB',
    :description        => 'Latest iPad 4 for prize',
    :picture            => 'http://google.com/image.jpg',
    :redemption_method  => 'pickup',
    :quantity_available => '12',
    :prizeable_type     => 'Prize::Item',
    :campaign_id        => 11
    }
  }

  describe '#create' do

    describe 'success scenarios' do

      it "should save and respond with 200 ok" do
        post :create, prize: prize, format: :json
        response.status.should == 200
        expect(response).to render_template('create')
      end

    end

    describe 'error scenarios' do

      before(:each) do
        prize[:campaign_id] = 11
        prize[:prizeable_type] = "Prize::Item"
        prize[:prize_name] = nil
      end

      it "should respond with a 422 status code and validation error" do
        post :create, prize: prize, format: :json
        response.status.should == 422
        JSON.parse(response.body).should == { "errors" => ["Prize name can't be blank"] }
      end

    end

  end

end