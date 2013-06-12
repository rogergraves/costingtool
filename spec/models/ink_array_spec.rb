require 'spec_helper'

describe InkArray do

  it "can belong to a click table" do
    click_table = FactoryGirl.create(:click_table)
    ink_array = FactoryGirl.create(:ink_array, :click_table => click_table)

    ink_array.click_table.should == click_table
  end

  it "dies when its parent click table is destroyed" do

  end

  it "can have many tiers" do
    ink_array = FactoryGirl.create(:ink_array)
    FactoryGirl.create(:tier, :ink_array => ink_array)
    FactoryGirl.create(:tier, :ink_array => ink_array)

    ink_array.reload.tiers.count.should == 2
  end

  it "Cannot have a color_range_start not between 0-6" do
    ink_array = FactoryGirl.create(:ink_array)
    ink_array.color_range_start = 7
    ink_array.should_not be_valid
    ink_array.color_range_start = -1
    ink_array.should_not be_valid
    ink_array.color_range_start = 3
    ink_array.should be_valid
  end
  
  it "Can only have a color_range_end between 0-6" do
    ink_array = FactoryGirl.create(:ink_array)
    ink_array.color_range_end = 7
    ink_array.should_not be_valid
    ink_array.color_range_end = -1
    ink_array.should_not be_valid
    ink_array.color_range_end = 3
    ink_array.should be_valid
  end
  
  it "color_range_end has to be >= color_range_start" do
    ink_array = FactoryGirl.create(:ink_array, :color_range_start => 3, :color_range_end => 3)
    ink_array.color_range_start = 6
    ink_array.should_not be_valid
    ink_array.color_range_end = 6
    ink_array.should be_valid
  end

  it "Can only have a black of 0-1" do
    ink_array = FactoryGirl.create(:ink_array)
    ink_array.black = 2
    ink_array.should_not be_valid
  end
end





