class PressTypeCostClick < PressTypeCost
  hstore :data, :accessors => {
      :colors_description => :string,
      :tier_start => :integer,
      :tier_end => :integer
  }

  validates_numericality_of :tier_start
  validates_numericality_of :tier_end
end
