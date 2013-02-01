require 'spec_helper'

describe Prize::MarketingMoney do

  describe 'validations' do
    it { should validate_presence_of(:prize_name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:picture)     }
    it { should validate_presence_of(:redemption_method) }
    it { should validate_presence_of(:quantity_available)}
    it { should validate_numericality_of(:quantity_available) }

    it "should use the correct table name" do
      Prize::MarketingMoney.table_name.should == 'prize_marketing_money'
    end
  end

end 