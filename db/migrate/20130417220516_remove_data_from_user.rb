class RemoveDataFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :data
  end

  def down
    add_column :users, :data, :hstore
  end
end
