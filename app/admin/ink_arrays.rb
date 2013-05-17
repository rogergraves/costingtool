ActiveAdmin.register InkArray do
  belongs_to :click_table

  sidebar "Click Tiers", :only => :show do
    ul do
      button link_to "See Tiers", admin_ink_array_tiers_path(ink_array.id)
    end
  end

  index do
    column :click_table
    column :description
    column :color_range_start
    column :color_range_end
    column :black
    default_actions
  end

  show do
    attributes_table do
      row :click_table
      row :description
      row :color_range_start
      row :color_range_end
      row :black
    end
  end

  form do |f|
    f.inputs "Ink Array" do
      f.input :click_table, :as => :select, :collection => ClickTable.all
      f.input :description
      f.input :color_range_start
      f.input :color_range_end
      f.input :black
    end
    f.buttons
  end

end
