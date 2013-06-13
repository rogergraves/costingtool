class RemoveColumnPressCostFromPressJob < ActiveRecord::Migration
  def up
    remove_column :press_jobs, :press_cost
  end

  def down
    add_column :press_jobs, :press_cost, :float
  end
end
