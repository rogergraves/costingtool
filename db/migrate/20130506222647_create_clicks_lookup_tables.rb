class CreateClicksLookupTables < ActiveRecord::Migration
  def change
    create_table :clicks_lookup_tables do |t|
      t.hstore :data

      t.timestamps
    end
  end
end
