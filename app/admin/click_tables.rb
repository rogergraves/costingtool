ActiveAdmin.register ClickTable do
    menu :parent => "Press Setup",:priority => 1

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
      columns do
        column do
          attributes_table do
              row :name, :label => "Name"
              row :description
              strong em{ link_to "View All Click Tables", admin_click_tables_path() }
          end
        end

        column do
          panel "Ink Arrays" do
            table_for(InkArray.find_all_by_click_table_id(click_table.id)) do
              column(:name) { |ink_array| link_to ink_array.name, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
              #column :color_range_start
              #column :color_range_end
              column :black do |value|
                  value.black == 0 ? "No" : "Yes"
              end
            end
              strong em { link_to "Add an Ink Array", new_admin_click_table_ink_array_path(click_table.id) }
          end
        end

      end # columns

    end # show

end

