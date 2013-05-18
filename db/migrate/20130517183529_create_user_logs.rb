class CreateUserLogs < ActiveRecord::Migration
  def change
    create_table :user_logs do |t|
      t.integer :user_id
      t.string :action
      t.hstore :data

      t.timestamps
    end
  end
end
