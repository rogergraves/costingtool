class ClicksLookupTable < ActiveRecord::Base
  attr_accessible :description, :label, :color_range_start, :color_range_end, :black, :volume_range_start, :volume_range_end, :price

  has_many :clicks_lookups

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :description => :string         # Description of number of color channels
  }

end


