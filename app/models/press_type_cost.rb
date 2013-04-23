class PressTypeCost < ActiveRecord::Base
  attr_accessible :cost, :description, :is_default, :press_type_id, :user_id
  belongs_to :user
  belongs_to :press_type
  validates_presence_of :press_type

  validates_presence_of :cost

  serialize :data, ActiveRecord::Coders::Hstore
end
