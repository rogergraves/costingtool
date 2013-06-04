ActiveAdmin.register Media do
    menu :label => "Media Costs", :parent => "Press Setup", :priority => 2
    config.clear_sidebar_sections!

  index :title => :name do
      column :name
    column :cost_per_sheet
    default_actions
  end

  show :title => :name do
    attributes_table do
      row :name
      row :cost_per_sheet
      strong em { link_to 'View All Media Costs', admin_media_path() }
    end
  end

  form do |f|
    f.inputs "Media" do
        f.input :name, :as => :select, :collection => Job.available_sizes, :include_blank => false
      f.input :cost_per_sheet, :hint => "cost per sheet = cost per ream / sheets per ream", :min => 0
    end
    f.buttons
  end


end
