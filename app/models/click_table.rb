class ClickTable < ActiveRecord::Base
  attr_accessible :description, :click_table_name, :name
  has_many :ink_arrays
  has_many :press_types

  validates_presence_of :name

  def display_name
    self.name
  end

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :click_table_name => :string,
      :name => :string
  }

end
