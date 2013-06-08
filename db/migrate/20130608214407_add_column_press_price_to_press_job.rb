class AddColumnPressPriceToPressJob < ActiveRecord::Migration
  def change
    add_column :press_jobs, :press_price, :float
  end
end


