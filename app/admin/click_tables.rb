ActiveAdmin.register ClickTable do
  index do
    column :description
    default_actions
  end

  show do
    attributes_table do
      row :ink_array
      row :description
    end
  end

end
