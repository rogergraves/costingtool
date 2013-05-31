ActiveAdmin.register Imposition do
    menu :parent => "Press Types", :priority => 2

  config.clear_sidebar_sections!

    index do
      panel "Impositions" do
        table_for(PressType.find_by_press_type_id(impositions.press_type_id)) do
          column :job_size
          column :ups
        end
    #column :press_type
    #column :job_size
    #column :ups
    #default_actions
      end
    end


  show do
    attributes_table do
      row :press_type
      row :job_size
      row :ups
    end
    em { link_to "View All Impositions", admin_impositions_path() }
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


