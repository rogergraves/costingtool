ActiveAdmin.register ClickTable do
    menu :priority => 3

  config.clear_sidebar_sections!

  index do
    column("Name", :sortable => :name, :sortable => :description) { |click_table| link_to click_table.name,
                                                                    admin_click_table_path(click_table.id) }
    column :description
  end

  form do |f|
    f.inputs "Click Table" do
      f.input :name, :label => "Name"
      f.input :description
    end
    f.buttons
  end


  show do

    attributes_table do
      row :name, :label => "Name"
      row :description
    end

    panel "Ink Arrays" do
      table_for(InkArray.find_all_by_click_table_id(click_table.id)) do
        column(:name) {|ink_array| link_to ink_array.name, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
        column :color_range_start
        column :color_range_end
        column :black do |value|
          value.black == 0? "No" : "Yes"
        end
      end
      strong { link_to "Add an Ink Array", new_admin_click_table_ink_array_path(click_table.id)}
    end

  end

  #sidebar "Links", :only => :show do
  #  ul do
  #    button_to "Add New Ink Array", new_admin_click_table_ink_array_path(click_table.id)
  #  end
  #end

end

