class PressType < ActiveRecord::Base
  attr_accessible :name, :icon

  has_attached_file :icon, styles: {
      medium: '200x100>',
      small: '100x50>'
  }
end
