require 'spec_helper'

describe Account::MarketingMoney do 

  let(:marketing_account) { Account::MarketingMoney.new }

  it "should use the right table_name" do
    Account::MarketingMoney.table_name.should == 'marketing_money_account'
  end

  it "should start out an account with 0.00 balance" do
    Account::MarketingMoney.new.balance.should == 0.00
  end

  it "should start out the limit at 1000.00" do
    Account::MarketingMoney.new.limit.should == 1000.00
  end

  describe "validations" do

    it { should validate_uniqueness_of(:owner_id).scoped_to(:business_id) }

  end

  describe '#load' do

    before(:each) do
      marketing_account.balance = 0.00
    end

    describe 'success scenarios' do

      it "should load the specified amount of money into the account" do
        marketing_account.load(100.00)
        marketing_account.balance.to_f.should == 100.00
      end

      it "should load the specified amount when a castable string is loaded" do
        marketing_account.load('20.15')
        marketing_account.balance.to_f.should == 20.15
      end

    end

    describe 'error scenarios' do

      it "should not change the balance when 0 is loaded" do
        marketing_account.load(0)
        marketing_account.balance.should == 0.0
      end

      it "should not change the balance when a string is loaded" do
        marketing_account.load('sjfhsoidhof')
        marketing_account.balance.should == 0.0
      end

      it "should not allow negative loads" do
        marketing_account.load(-100)
        marketing_account.errors[:balance].should_not be_nil
        marketing_account.errors[:balance].should include('You cannot use a negative amount to load this account')
        marketing_account.balance.should == 0.00
      end

      it "should not allow over the limit loads" do
        marketing_account.load(1001.00)
        marketing_account.errors[:limit].should_not be_nil
        marketing_account.errors[:limit].should include('You cannot load this account beyond it\'s allowed limit')
        marketing_account.balance.should == 0.00
      end

      it "should not allow a load if amount goes beyond limit" do
        marketing_account.balance = 995.00
        marketing_account.load(200.01)
        marketing_account.errors[:limit].should_not be_nil
        marketing_account.errors[:limit].should include('The load operation is causing to hit your limit threshold. Try a lower amount')
        marketing_account.balance == 995.00
      end

    end

  end

  describe '#withdraw' do

    before(:each) do
      marketing_account.balance = 100.00
    end

    describe 'success scenarios' do

      it "should withdraw the specified amount of money from account" do
        marketing_account.withdraw(10.95)
        marketing_account.balance.should == 89.05
      end

      it "should withdraw the specified amount when a castable string is withdrawn" do
        marketing_account.withdraw('20.15')
        marketing_account.balance.to_f.should == 79.85
      end
      
    end

    describe 'error scenarios' do

      it "should not withdraw anything when amount specified is 0.00" do
        marketing_account.withdraw(0.0)
        marketing_account.balance.to_f.should == 100.0
      end

      it "should not withdraw from the balance when a string is used" do
        marketing_account.load('sjfhsoidhof')
        marketing_account.balance.should == 100.0
      end

      it "should not allow negative withdraws" do
        marketing_account.withdraw(-10)
        marketing_account.errors[:balance].should_not be_nil
        marketing_account.errors[:balance].should include('You cannot use a negative or 0.00 amount to withdraw from this account')
        marketing_account.balance.should == 100.00
      end

      it "should not allow withdraws more than the balance" do
        marketing_account.withdraw(100.01)
        marketing_account.errors[:limit].should_not be_nil
        marketing_account.errors[:limit].should include('Insufficient Funds: Cannot withdraw')
        marketing_account.balance.should == 100.00
      end

      it "should not allow withdraws more than the limit" do
        marketing_account.withdraw(1000.01)
        marketing_account.errors[:limit].should_not be_nil
        marketing_account.errors[:limit].should include('Withdraw\'s more than the account limits are not allowed')
        marketing_account.balance == 100.00
      end

    end

  end

end