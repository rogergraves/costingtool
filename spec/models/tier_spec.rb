require 'spec_helper'

describe Tier do

  it "can belong to a ink_array" do
    ink_array = FactoryGirl.create(:ink_array)
    tier = FactoryGirl.create(:tier, :ink_array => ink_array)

    tier.ink_array.should == ink_array
  end

  it "must have a volume_range_start of greater or equal than zero" do
    tier = FactoryGirl.create(:tier)
    tier.volume_range_start = -1
    tier.should_not be_valid
  end

  it "can have a nil value for volume_range_end" do
    tier = FactoryGirl.create(:tier)
    tier.volume_range_end = nil
    tier.should be_valid
  end

  it "can have a black_price" do
    tier = FactoryGirl.create(:tier, :black_price => 0.95)
    tier.black_price.should == 0.95
  end
end





