class AddIconToPressTypes < ActiveRecord::Migration
  def up
    add_attachment :press_types, :icon
  end

  def down
    remove_attachment :press_types, :icon
  end
end
