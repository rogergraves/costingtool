class InkArray < ActiveRecord::Base
  attr_accessible :black, :color_range_end, :color_range_start, :description, :ink_table_name, :click_table_id
  belongs_to :click_table
  has_many :tiers

  validates_numericality_of :color_range_start, :only_integer => true
  validates_numericality_of :color_range_end, :only_integer => true
  validates_inclusion_of :color_range_start, :presence => true, :in => 0..6
  validates_inclusion_of :color_range_end, :presence => true, :in => 0..6
  validates :color_range_end, :numericality => { :greater_than_or_equal_to => :color_range_start }
  validates_numericality_of :black, :only_integer => true
  validates_inclusion_of :black, :in => 0..1

  def name
    self.description
  end

end
