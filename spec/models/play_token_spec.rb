require 'spec_helper'

describe PlayToken do 

  it "should use the right table name" do
    PlayToken.table_name.should == 'play_tokens'
  end

  it "should start out with an initial state of unplayed" do
    PlayToken.new.state.should == 'unplayed'
  end

end