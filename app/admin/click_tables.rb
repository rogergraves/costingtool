ActiveAdmin.register ClickTable do

  sidebar "Ink Arrays", :only => :show do
    ul do
      link_to "View Ink Arrays for this Table", admin_click_table_ink_arrays_path(click_table.id)
    end
  end

  index do
    column :id
    column :click_table_name
    column :description
    default_actions
  end

  show do
    attributes_table do
      row :click_table_name
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

