class Media < ActiveRecord::Base
  attr_accessible :cost_per_sheet, :name
  validates_inclusion_of :name, :in => Job.available_sizes
  validates_uniqueness_of :name
end
