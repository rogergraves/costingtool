class CreatePressTypes < ActiveRecord::Migration
  def change
    create_table :press_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
