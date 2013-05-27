class InkArray < ActiveRecord::Base
  attr_accessible :black, :color_range_end, :color_range_start, :name, :ink_table_name, :click_table_id
  belongs_to :click_table
  has_many :tiers, :dependent => :destroy

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
  }

  validates_numericality_of :color_range_start, :only_integer => true
  validates_numericality_of :color_range_end, :only_integer => true
  validates_inclusion_of :color_range_start, :in => 0..6 #:presence => true
  validates_inclusion_of :color_range_end, :in => 0..6 #:presence => true
  validates :color_range_end, :numericality => { :greater_than_or_equal_to => :color_range_start }
  validates_numericality_of :black, :only_integer => true
  validates_inclusion_of :black, :in => 0..1

end
