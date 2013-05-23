class Tier < ActiveRecord::Base
  attr_accessible :label, :price, :volume_range_end, :volume_range_start, :ink_array_id, :black_price
  belongs_to :ink_array
  delegate :click_table, :to => :ink_array, :allow_nil => true

  validates :volume_range_start, :numericality => { :greater_than_or_equal_to => 0 }
  validates_numericality_of :price

  def tier_name
    self.label
  end

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :black_price => :float,
  }

end
