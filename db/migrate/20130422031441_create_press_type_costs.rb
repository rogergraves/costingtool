class CreatePressTypeCosts < ActiveRecord::Migration
  def change
    create_table :press_type_costs do |t|
      t.integer :press_type_id
      t.integer :user_id
      t.string :description
      t.float :cost
      t.boolean :is_default
      t.string :type
      t.hstore :data

      t.timestamps
    end
  end
end
