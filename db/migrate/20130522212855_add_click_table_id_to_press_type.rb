class AddClickTableIdToPressType < ActiveRecord::Migration
  def change
    add_column :press_types, :click_table_id, :integer
  end
end
