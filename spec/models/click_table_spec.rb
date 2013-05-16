require 'spec_helper'

describe ClickTable do

  it "can have many ink_arrays" do
    click_table = FactoryGirl.create(:click_table)
    ink_array = FactoryGirl.create(:ink_array, :click_table => click_table)

    ink_array.click_table.should == click_table
  end

end





