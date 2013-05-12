class CreateImpositions < ActiveRecord::Migration
  def change
    create_table :impositions do |t|
      t.integer :press_type_id
      t.string :job_size
      t.integer :ups

      t.timestamps
    end
  end
end
