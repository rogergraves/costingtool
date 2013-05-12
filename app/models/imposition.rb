class Imposition < ActiveRecord::Base
  attr_accessible :job_size, :press_type_id, :ups
  belongs_to :press_type

  validates_inclusion_of :job_size, :in => PressTypeCostMedia.job_sizes
  validates_uniqueness_of :job_size, :scope => :press_type_id

end
