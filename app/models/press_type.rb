class PressType < ActiveRecord::Base
  attr_accessible :name, :icon, :duty_cycle, :spi, :click_table_id, :click_table_name
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
      :click_table_id => :integer,  #the ClickTable.id that this PressType belongs_to
      :duty_cycle => :integer,      # Max usage of a press per month
      :spi => :float,                # Service Parts Insurance cost / month in USD
      :click_table_name => :string,
      :impositions => :integer
  }
end
