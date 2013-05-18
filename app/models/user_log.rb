class UserLog < ActiveRecord::Base
  attr_accessible :action, :user_id

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {}

end
