class CreateInkArrays < ActiveRecord::Migration
  def change
    create_table :ink_arrays do |t|
      t.integer :click_table_id
      t.string :description
      t.integer :color_range_start
      t.integer :color_range_end
      t.integer :black
      t.hstore :data

      t.timestamps
    end
  end
end
