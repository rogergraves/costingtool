require 'spec_helper'

describe ClicksLookupTable do
  before { @lookup_table = ClicksLookupTable.create(:description => "Multi color") }

  subject { @lookup_table }

  it { should respond_to(:description) }
  it { should be_valid }

end





