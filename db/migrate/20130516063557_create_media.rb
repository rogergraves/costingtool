class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :name
      t.float :cost_per_sheet

      t.timestamps
    end
  end
end
