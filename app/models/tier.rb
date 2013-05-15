class Tier < ActiveRecord::Base
  attr_accessible :label, :price, :volume_range_end, :volume_range_start, :ink_array_id
  belongs_to :ink_array

  validates :volume_range_start, :numericality => { :greater_than_or_equal_to => 0 }
  validates_numericality_of :price

end
