class AddDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :data, :hstore
  end
end
