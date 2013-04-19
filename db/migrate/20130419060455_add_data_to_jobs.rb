class AddDataToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :data, :hstore
  end
end

