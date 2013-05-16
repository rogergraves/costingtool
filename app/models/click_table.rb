class ClickTable < ActiveRecord::Base
  attr_accessible :description, :click_table_name
  has_many :ink_arrays
  has_many :press_types

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :click_table_name => :string,  #the name of the ClickTable - for ease of viewing
  }

end
