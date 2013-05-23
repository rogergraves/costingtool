class RenameClickTableNameToNameOnClickTable < ActiveRecord::Migration
  def change
    ClickTable.all.each do |click_table|
      name = click_table.click_table_name
      click_table.update_attributes(:name => name)
    end

    execute("UPDATE click_tables SET data = delete(data, 'click_table_name')")
  end
end