class ClicksLookup < ActiveRecord::Base
  attr_accessible :clicks_lookup_table_id, :click_description, :tier_label, :color_range_start, :color_range_end, :black,
      :volume_range_start, :volume_range_end, :price

  belongs_to :clicks_lookup_table

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

  #color_range validations -- min: 0, not nil; max: 6 not nil
  validates_numericality_of :color_range_start, :only_integer => true
  validates_numericality_of :color_range_end, :only_integer => true
  validates_inclusion_of :color_range_start, :presence => true, :in => 0..6
  validates_inclusion_of :color_range_end, :presence => true, :in => 0..6
  validates :color_range_end, :numericality => { :greater_than_or_equal_to => :color_range_start}
  #validates_format_of :color_range_end =>

  #volume_range validations -- min: 0 (not nil), max: :nil = infinity
  validates :volume_range_start, :numericality => { :greater_than_or_equal_to => 0 }
  #validates_presence_of :volume_range_end, :allow_nil => true

  #
  #:in => { :greater_than_or_equal_to => :volume_range_start }, :allow_nil => true

  #black validations -- min: 0, max: 1, not nil
  validates_numericality_of :black, :only_integer => true


  #price validations -- min: 0, max: undefined, not nil
  validates_numericality_of :price
  #validates_inclusion_of :price, :presence => true, :in => { :greater_than_or_equal_to => 0 }


end
