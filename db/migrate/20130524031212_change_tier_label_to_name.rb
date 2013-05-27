class ChangeTierLabelToName < ActiveRecord::Migration
  def up
    rename_column :tiers, :label, :name
  end

  def down
    rename_column :tiers, :name, :label
  end
end
