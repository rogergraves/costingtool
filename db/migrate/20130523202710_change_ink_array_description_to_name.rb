class ChangeInkArrayDescriptionToName < ActiveRecord::Migration
  def up
    rename_column :ink_arrays, :description, :name
  end

  def down
    rename_column :ink_arrays, :name, :description
  end
end
