class AddDataToPressTypes < ActiveRecord::Migration
  def change
    add_column :press_types, :data, :hstore
  end
end
