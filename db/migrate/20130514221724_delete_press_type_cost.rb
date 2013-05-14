class DeletePressTypeCost < ActiveRecord::Migration
  def change
    drop_table :press_type_costs if ActiveRecord::Base.connection.tables.include?("press_type_costs")
  end
end
