class AddColumnsCostPerSheetAndClickPriceToPressJob < ActiveRecord::Migration
  def change
    add_column :press_jobs, :cost_per_sheet, :float
    add_column :press_jobs, :click_price, :float
  end
end
