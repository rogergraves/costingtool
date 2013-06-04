ActiveAdmin.register Imposition do
    menu false
    scope :all, :default => true

  config.clear_sidebar_sections!

    index do
      column :press_type
      column :job_size
      column :ups
    end




  show do
    attributes_table do
      row :press_type
      row :job_size
      row :ups
    end
    strong em { link_to "View All Presses", admin_press_types_path() }
  end

  form do |f|
    f.inputs "Impositions" do
      f.input :press_type, :as => :select, :collection => PressType.all, :include_blank => false
      f.input :job_size, :as => :select, :collection => Job.available_sizes, :include_blank => false
      f.input :ups, :as => :select, :collection => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], :include_blank => false
    end
    f.buttons
  end
end


