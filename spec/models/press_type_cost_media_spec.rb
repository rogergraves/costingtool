require 'spec_helper'

describe PressTypeCostMedia do

  context "PressTypeCostMedia.job_sizes" do
    it 'returns 6"x9", 7"x10", A5, A4, A3, B2' do
      PressTypeCostMedia.job_sizes.should == ['6"x9"', '7"x10"', 'A5', 'A4', 'A3', 'B2']
    end
  end

end
