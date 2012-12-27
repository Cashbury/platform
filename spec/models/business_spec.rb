require 'spec_helper'

describe Business do
  
  describe 'validations' do
    it { should validate_presence_of(:legal_name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:state) }
  end

  describe 'valid values' do
  	it {should allow_value('Starbucks Canada Inc.').for(:legal_name) }
  	it {should allow_value('Starbucks').for(:name) }
  	it {should allow_value('Starbucks is good coffee place').for(:description) }
  end
  
end
