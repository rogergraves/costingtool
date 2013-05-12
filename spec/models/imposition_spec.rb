require 'spec_helper'

describe Imposition do
  let(:press) {FactoryGirl.create(:press_type, :name => "My Press", :spi => 1000)}
  let(:press2) {FactoryGirl.create(:press_type, :name => "My Press 2", :spi => 2000)}

  it "enforces valid job sizes" do
    invalid_imposition = Imposition.create(:press_type_id => press.id, :job_size => 'crap', :ups => 3)
    invalid_imposition.valid?.should be_false

    valid_imposition = Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3)
    valid_imposition.valid?.should be_true
  end

  it "doesn't allow a duplicate ups entry for a given press type" do
    Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3).valid?.should be_true
    Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.last, :ups => 3).valid?.should be_true
    Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3).valid?.should be_false
  end

  it "allows duplicate entries for different press types" do
    Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3).valid?.should be_true
    Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3).valid?.should be_false
    Imposition.create(:press_type_id => press2.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3).valid?.should be_true
  end

  it "deleting a press type also deletes the child imposition fields" do
    i = Imposition.create(:press_type_id => press.id, :job_size => PressTypeCostMedia.job_sizes.first, :ups => 3)
    press.destroy
    Imposition.exists?(i).should be_false
  end
end
