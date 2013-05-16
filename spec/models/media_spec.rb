require 'spec_helper'

describe Media do
  it "can only have a name that comes from Job.available_sizes" do
    media = FactoryGirl.create(:media)
    media.name.should == Job.available_sizes.first
    media.name = "Some Crap"
    media.should_not be_valid
  end

  it "cannot not have duplicate names" do
    media1 = FactoryGirl.create(:media)
    media2 = FactoryGirl.create(:media)

    media1.name.should_not == media2.name
    media2.name = media1.name
    media2.should_not be_valid
  end
end





