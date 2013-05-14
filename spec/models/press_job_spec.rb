require 'spec_helper'

describe PressJob do
  let(:job) { FactoryGirl.create(:job) }
  let(:press_type) { FactoryGirl.create(:press_type) }
  let(:press_job) { FactoryGirl.create(:press_job, :job => job, :press_type => press_type)}

  it "stores press_cost, media_cost, labor_cost, spi_cost and clicks_cost" do
    press_job.valid?.should be_true
  end

  it "belongs to a jobs" do
    press_job.job.should == job
  end
  it "belongs to a press_type" do
    press_job.press_type.should == press_type
  end

end





