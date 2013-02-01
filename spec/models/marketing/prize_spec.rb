require 'spec_helper'

describe Marketing::Prize do

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'associations' do
    it { should belong_to(:prizeable) }
  end

  describe 'table name' do
    it "should be set to proper table name" do
      Marketing::Prize.table_name.should == 'marketing_prizes'
    end
  end

end