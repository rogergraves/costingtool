require 'spec_helper'

describe ClicksLookupTable do
  before { @lookup_table_row = ClicksLookupTable.create(:description => "Multi color", :label => "Tier 1", :color_range_start => 3, :color_range_end => 6, :black => 1, :volume_range_start => 1, :volume_range_end => 4,:price => 10.0) }

  subject { @lookup_table_row }

  it { should respond_to(:description) }
  it { should respond_to(:label) }
  it { should respond_to(:color_range_start) }
  it { should respond_to(:color_range_end) }
  it { should respond_to(:black) }
  it { should respond_to(:volume_range_start) }
  it { should respond_to(:volume_range_end) }
  it { should respond_to(:price) }

  it { should be_valid }

  #color_range_start tests

  describe "color_range_start should be between 0 and 6" do
    before { @lookup_table_row.color_range_start = 50 }
    it { should_not be_valid }
  end

  #describe "color_range_start should be a number, not a string" do
  #  before { @lookup_table_row.color_range_start = "woohoo!"}
  #  it { should_not be_valid }
  #end

  describe "color_range_start should be less than or equal to color_range_end" do
    before { @lookup_table_row.color_range_start = 6}
    before { @lookup_table_row.color_range_end = 3 }
    it { should_not be_valid }
  end


  #color_range_end tests

  describe "color_range_end should be between 0 and 6" do
    before { @lookup_table_row.color_range_end = 50 }
    it { should_not be_valid }
  end

  #describe "color_range_end should be a number not a string" do
  #  before { @lookup_table_row.color_range_end = "woohoo!" }
  #  it { should_not be_a_kind_of(String) }
  #end

  describe "color_range_end can not be nil" do
    before { @lookup_table_row.color_range_end = :nil }
    it { should_not be_valid }
  end


  #black tests

  #describe "black should be a number (0 or 1), not a string" do
  #  before { @lookup_table_row.black = "woohoo!"}
  #  it { should_not be_valid }
  #end


  ##volume_range tests

  #describe "volume_range_start should be a number not a string" do
  #  before { @lookup_table_row.volume_range_start = "woohoo!"}
  #  it { should_not be_valid }
  #end

  #describe "volume_range_start should be less than volume_range_end" do
  #  before { @lookup_table_row.volume_range_start = 6 }
  #  before { @lookup_table_row.volume_range_end = 3 }
  #  it { should_not be_valid }
  #end

  describe "volume_range_end can be nil" do
    before { @lookup_table_row.volume_range_end = nil }
    it { should be_valid }
  end

  #describe "when volume_range_end is not a number" do
  #  before { @lookup_table_row.volume_range_end = "woohoo!" }
  #  it { should_not be_valid }
  #end


  ##price tests

  #describe "when price is not a number" do
  #  before { @lookup_table_row.price = "woohoo!" }
  #  it { should_not be_valid }
  #end

end





