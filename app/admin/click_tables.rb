ActiveAdmin.register ClickTable do

  sidebar "Ink Arrays" do
    ul do
      link_to "Ink Arrays for this table", "#{request.protocol}#{request.host_with_port}#{request.fullpath}/ink_arrays"
    end
  end

  index do
    column :description
    default_actions
  end

  show do
    attributes_table do
      row :description
    end
  end

  form do |f|
    f.inputs "Click Table" do
      f.input :description
    end
    f.buttons
  end

end

