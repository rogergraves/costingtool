require 'spec_helper'

describe PressType do

  let(:press) {FactoryGirl.create(:press_type, :name => "My Press", :spi => 1000, :labor => 400, :price => 500000, :production_life_months => 84)}

  context "fields" do
    it "Press Factory works" do
      press.name.should == "My Press"
      press.spi.should == 1000
      press.labor.should == 400
      press.price.should == 500000
      press.production_life_months.should == 84
    end
  end

  it "can belong to a click table" do
    click_table = FactoryGirl.create(:click_table)
    press_type = FactoryGirl.create(:press_type, :click_table => click_table)

    press_type.click_table.should == click_table
  end

end
