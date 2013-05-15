class CreateClickTables < ActiveRecord::Migration
  def change
    create_table :click_tables do |t|
      t.string :description
      t.hstore :data

      t.timestamps
    end
  end
end
