class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.integer :ink_array_id
      t.string :label
      t.integer :volume_range_start
      t.integer :volume_range_end
      t.float :price
      t.hstore :data

      t.timestamps
    end
  end
end
