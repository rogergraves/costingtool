require 'spec_helper'

describe Job do

  context "Job.available_sizes" do
    it 'returns 6"x9", 7"x10", A5, A4, A3, B2' do
      Job.available_sizes.should == ['6"x9"', '7"x10"', 'A5', 'A4', 'A3', 'B2']
    end
  end

end
