class ClicksLookupTable < ActiveRecord::Base
  attr_accessible :click_description, :tier_label, :color_range_start, :color_range_end, :black, :volume_range_start, :volume_range_end, :price

  has_many :clicks_lookups

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :click_description => :string,  # Describes colors used
      :tier_label => :string,         # Tier label, not :nil
      :color_range_start => :integer, # must be between 0-6, not :nil
      :color_range_end => :integer,   # greater than or equal to start, between 0-6, not :nil
      :black => :integer,             # 0 or 1, not :nil
      :volume_range_start => :integer,# greater than 0
      :volume_range_end => :integer,  # greater than or equal to start, nil = 0
      :price => :integer
  }

end


