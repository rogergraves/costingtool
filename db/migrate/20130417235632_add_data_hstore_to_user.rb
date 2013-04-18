class AddDataHstoreToUser < ActiveRecord::Migration
  def up
    add_column :users, :data, :hstore
  end

  def down
    remove_column :users, :data
  end
end
