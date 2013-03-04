require 'spec_helper'

describe User do

  let(:user) { stub_model(User) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should ensure_length_of(:first_name).is_at_least(2).is_at_most(30) }
    it { should ensure_length_of(:last_name).is_at_least(2).is_at_most(30) }

    it { should validate_presence_of(:password) }
    it { should ensure_length_of(:password).is_at_least(6).is_at_most(32) }
  end

  describe 'valid values' do
    it { should allow_value('Jasdeep').for(:first_name) }
    it { should allow_value('Narang').for(:last_name) }
    it { should allow_value('narang.jasdeep@gmail.com').for(:email) }
  end

  describe 'invalid values' do

    describe 'empty strings' do
      
      # empty strings
      it { should_not allow_value('').for(:first_name) }
      it { should_not allow_value('').for(:last_name)  }
      it { should_not allow_value('').for(:email)      }

      # long empty strings
      it { should_not allow_value('    ').for(:first_name) }
      it { should_not allow_value('    ').for(:last_name)  }
      it { should_not allow_value('    ').for(:email)      }

      # invalid
      it { should_not allow_value('test').for(:email)        }
      it { should_not allow_value('test@domain').for(:email) }
      it { should_not allow_value('testdomain.com').for(:email) }

      it { should_not allow_value('J').for(:first_name) }
      it { should_not allow_value('N').for(:last_name)  }

      # too long
      it { should_not allow_value('thirty characters long string for first name of a user').for(:first_name) }
      it { should_not allow_value('thirty characters long string for last name of a user ').for(:last_name)  }

    end

  end

  describe "#reset_authentication_token!" do

    it "resets the authentication token" do
      user.authentication_token = 'something'
      user.reset_authentication_token!
      user.authentication_token.should_not == 'something'
    end

    it "should call the SecureRandom lib to generate a token" do
      user.authentication_token = 'something'
      SecureRandom.should_receive(:hex).with(24)
      user.reset_authentication_token!
    end

  end

  describe "#award_tokens(count, business)" do

    let(:business) { stub_model(Business, id: 11) }

    before(:each) do
      user.stub(:valid) { true }
      user.stub(:save)  { user }
    end

    it "should award tokens to the user as per the count and within scope of the business" do
      user.award_tokens(2, business)
      user.play_tokens.should_not be_nil
    end

  end

  describe "#marketing_money_balance_at(business)" do

    let(:business) { stub_model(Business, id: 10) }

    it "returns the marketing money balance at a business for the user" do
      user.stub_chain(:marketing_money_accounts, :for_business ) { [stub_model(Account::MarketingMoney, balance: 123.45, business_id: 10)] }
      user.marketing_money_balance_at(business).should == 123.45
    end

    it "returns 0.00 when there is no marketing account" do
      user.stub(:marketing_money_accounts) { [] }
      user.marketing_money_balance_at(business).should == 0.00
    end

  end

end