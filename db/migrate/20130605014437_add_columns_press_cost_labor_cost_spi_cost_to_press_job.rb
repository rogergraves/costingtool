class AddColumnsPressCostLaborCostSpiCostToPressJob < ActiveRecord::Migration
  def change
    add_column :press_jobs, :press_cost, :float
    add_column :press_jobs, :labor_cost, :float
    add_column :press_jobs, :spi_cost, :float
  end
end