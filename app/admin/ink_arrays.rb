ActiveAdmin.register InkArray do
  belongs_to :click_table

  sidebar "Tiers" do
    ul do
      link_to 'Tiers for this Ink Array', "#{request.protocol}#{request.host_with_port}#{request.fullpath}/tiers"
    end
  end

  index do
    column :click_table_id
    column :description
    column :color_range_start
    column :color_range_end
    column :black
    default_actions
  end

  show do
    attributes_table do
      row :click_table_id
      row :description
      row :color_range_start
      row :color_range_end
      row :black
    end
  end

  form do |f|
    f.inputs "Ink Array" do
      f.input :description
      f.input :color_range_start
      f.input :color_range_end
      f.input :black
    end
    f.buttons
  end
  
end
