class PressType < ActiveRecord::Base
  attr_accessible :name, :icon, :duty_cycle, :spi
  has_many :press_type_costs
  has_many :press_type_cost_clicks
  has_many :press_type_cost_labors
  has_many :press_type_cost_medias
  has_many :press_type_cost_services

  has_attached_file :icon, styles: {
      medium: '200x100>',
      small: '100x50>'
  }

  validates_presence_of :name

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :duty_cycle => :integer,     # Max usage of a press per month
      :spi => :float                # Service Parts Insurance cost / month in USD
  }
end
