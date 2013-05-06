require 'spec_helper'

describe PressType do
  let(:press) {FactoryGirl.create(:press_type, :name => "My Press", :spi => 1000)}
  context "fields" do
    it "Press Factory works" do
      press.name.should == "My Press"
      press.spi.should == 1000

      ap press
    end
  end





end
