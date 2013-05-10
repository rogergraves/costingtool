class CreateClicksLookups < ActiveRecord::Migration
  def change
    create_table :clicks_lookups do |t|
      t.integer :clicks_lookup_table_id
      t.hstore :data

      t.timestamps
    end
  end
end
