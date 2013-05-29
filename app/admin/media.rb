ActiveAdmin.register Media do

  index :title => :name do
      column :name
    column :cost_per_sheet
    default_actions
  end

  show :title => :name do
    attributes_table do
      row :name
      row :cost_per_sheet
    end
  end

  form do |f|
    f.inputs "Media" do
        f.input :name, :as => :select, :collection => Job.available_sizes
      f.input :cost_per_sheet, :hint => "cost per sheet = cost per ream / sheets per ream"
    end
    f.buttons
  end


end
