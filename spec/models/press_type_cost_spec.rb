require 'spec_helper'

describe PressTypeCost do
  let(:user) { FactoryGirl.create(:user) }
  let(:press_type) { FactoryGirl.create(:press_type) }
  let(:valid_cost) { PressTypeCost.create(:user_id => user.id, :press_type_id => press_type.id, :cost => 10.00) }

  it "should require a cost entry amount" do
    # Move to press_type_cost_spec.rb
    valid_cost.valid?.should be_true
    invalid_cost = PressTypeCost.create(:description => "Hourly", :user_id => user.id, :press_type_id => press_type.id)
    invalid_cost.valid?.should be_false
  end
  context "PressType" do
    it "should belong to a PressType" do
      valid_cost.press_type.should == press_type
    end
    it "require a PressType" do
      invalid_cost = PressTypeCost.create(:description => "Hourly", :user_id => user.id, :cost => 10.00)
      invalid_cost.valid?.should be_false
    end
  end
  context "User" do
    it "should belong to a user" do
      valid_cost.user.should == user
    end
  end


end
