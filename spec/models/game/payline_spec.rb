require 'spec_helper'

describe Game::Payline do
  
  describe "validations" do
    it { should ensure_inclusion_of(:group).in_array(['national', 'business']) }
  end

end
