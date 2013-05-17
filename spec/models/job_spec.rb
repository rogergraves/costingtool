require 'spec_helper'

describe Job do

  context "Job.available_sizes" do
    it 'returns 6"x9", 7"x10", A5, A4, A3, B2' do
      Job.available_sizes.should == ['6"x9"', '7"x10"', 'A5', 'A4', 'A3', 'B2']
    end

    it ':job_size has to be one of the values in Job.available_sizes' do
      job = FactoryGirl.create(:job)
      job.should be_valid
      job.job_size = 'some crap'
      job.should_not be_valid
    end
  end



end
