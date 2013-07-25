require 'spec_helper'

describe Marketing::Prize do

  let(:user)  { stub_model(User) }
  let(:marketing_prize) { stub_model(Marketing::Prize, name: 'Some Prize Item') }
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

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :group }
    it { should ensure_inclusion_of(:group).in_array(['national', 'business']) }
  end

  describe 'associations' do
    it { should belong_to(:prizeable) }
    it { should belong_to(:payline)   }
  end

  describe 'table name' do
    it "should be set to proper table name" do
      Marketing::Prize.table_name.should == 'marketing_prizes'
    end
  end

  describe 'class methods' do

    describe '.api_create' do

      before(:each) do
        @param = { prize: prize }
      end

      describe 'success scenarios' do

        it "saves successfully when everthing is good" do
          response = Marketing::Prize.api_create(@param, user)
          response[:success].should_not be_nil
          response[:errors].should be_nil
        end

      end

      describe 'error scenarios' do

        before(:each) do
          prize[:campaign_id] = 11
          prize[:prizeable_type] = 'Prize::Item'
          prize[:prize_name] = nil
        end

        it "should return error when validation fails" do
          response = Marketing::Prize.api_create(@param, user)
          response[:errors].should be_present
          response[:errors].should include("Prize name can't be blank")
          response[:success].should be_nil
        end

        it "should render error if prizeable_type is not present" do
          pending 'should output a graceful error if prizeable_type is not defined'
        end

        it "should render error if campaign_id is not present" do
          
        end

      end

    end

  end

  describe "#unlock_prize(user)" do

    let(:prizeable) { stub_model(Prize::Item, quantity_available: 10) }

    before(:each) do
      marketing_prize.stub(:prizeable) { prizeable }
      marketing_prize.unlock_for(user)
    end

    it "should add a prize instance to user_prizes" do
      user.user_prizes.should_not be_nil
    end

    it "should award the prize to a user" do
      user.prizes.should include(marketing_prize)
    end

    it "should reduce the available quantity and call decrement quantity" do
      prizeable.should_receive(:decrement_quantity) 
      marketing_prize.unlock_for(user)
    end

  end

  describe "#assign_to_payline" do

    let(:payline) { stub_model(Game::Payline, id: 10) }

    it "assigns self to a payline" do
      marketing_prize.assign_to_payline(payline)
      marketing_prize.payline.should == payline
    end

  end

end