ActiveAdmin.register ClickTable do

  sidebar "Ink Arrays", :only => :show do
    ul do
      button link_to "View Ink Arrays", admin_click_table_ink_arrays_path(click_table.id)
    end
  end

  index do
    selectable_column
    column :click_table_name, :label => "Name"
    column :description
    default_actions
  end

  show do
    attributes_table do
      row :click_table_name, :label => "Name"
      row :description
    end
  end

  form do |f|
    f.inputs "Click Table" do
      f.input :click_table_name, :label => "Name"
      f.input :description
    end
    f.buttons
  end

end