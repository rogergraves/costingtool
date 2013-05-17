ActiveAdmin.register Imposition do


  sidebar "Job Sizes", :only => :show do
    ul do
      button link_to "View All Impositions", admin_impositions_path
    end
  end

  index do
    column :press_type
    column :job_size
    column :ups
    default_actions
  end

  show do
    attributes_table do
      row :press_type
      row :job_size
      row :ups
    end
  end

  form do |f|
    f.inputs "Impositions" do
      f.input :press_type, :as => :select, :collection => PressType.all
      f.input :job_size, :as => :select, :collection => Job.available_sizes
      f.input :ups, :as => :select, :collection => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    end
    f.buttons
  end
end


