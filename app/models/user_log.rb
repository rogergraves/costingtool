class UserLog < ActiveRecord::Base
  attr_accessible :action, :user_id

  belongs_to :user

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {}

  def name
    self.user_id
  end

end
