class CreatePressJobs < ActiveRecord::Migration
  def change
    create_table :press_jobs do |t|
      t.integer :press_type_id
      t.integer :job_id
      t.hstore :data

      t.timestamps
    end
  end
end
