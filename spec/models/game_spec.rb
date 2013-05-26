require 'spec_helper'

describe Game do
  
  describe "validations" do

    it { should validate_numericality_of(:max_national_prizes) }
    it { should validate_numericality_of(:max_merchant_prizes) }

  end

end
