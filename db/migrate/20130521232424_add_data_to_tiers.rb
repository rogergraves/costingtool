class AddDataToTiers < ActiveRecord::Migration
  def change
    add_column :tiers, :data, :hstore unless Tier.column_names.include?('data')
  end
end
