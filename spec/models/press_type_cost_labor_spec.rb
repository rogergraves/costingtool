require 'spec_helper'

describe PressTypeCostLabor do
  let(:user) { User.create(:email => 'someone@something.com', :password => 'password') }
  let(:press_type) { PressType.create(:name => 'My Press 2000') }

  it "should only allow Hourly, Daily or Monthly descriptions"


end
