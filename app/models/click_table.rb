class ClickTable < ActiveRecord::Base
  attr_accessible :description
  has_many :ink_arrays
  has_many :press_types



end
