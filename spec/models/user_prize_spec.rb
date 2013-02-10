require 'spec_helper'

describe UserPrize do

  it { UserPrize.table_name.should == 'user_prizes' }
  
end