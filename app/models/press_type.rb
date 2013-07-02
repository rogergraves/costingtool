class PressType < ActiveRecord::Base
  attr_accessible :name, :icon, :duty_cycle, :spi, :click_table_id, :price, :labor, :production_life_months
  has_many :press_jobs
  has_many :impositions, :dependent => :destroy
  belongs_to :click_table

  has_attached_file :icon, styles: {
      medium: '200x100>',
      small: '100x50>'
  }

  validates_presence_of :name

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :duty_cycle => :integer,                  # Max # of press clicks per month
      :spi => :float,                           # Service Parts Insurance cost / month in USD
      :labor => :float,                         # The labor in USD
      :price => :float,                         # The total price of the press - this is divided by 60 in the calculations to display the monthly cost (in USD)
      :production_life_months => :integer,      # Expected number of months the machine should last (life cycle)
  }
end