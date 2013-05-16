ActiveAdmin.register Media do

  index do
    column :name
    column :cost_per_sheet
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :cost_per_sheet
    end
  end

  form do |f|
    f.inputs "Media" do
      f.input :name
      f.input :cost_per_sheet, :hint => "(cost per ream / sheets per ream)"
    end
    f.buttons
  end


end
