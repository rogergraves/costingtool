ActiveAdmin.register ClicksLookupTable do
  sidebar "Clicks Lookup Entries" do
    ul do
      li link_to("Create entries")
      # new_admin_clicks_lookup_table_clicks_lookup_path(clicks_lookup_table))
      #
      #if clicks_lookup_table.clicks_lookups.present?
      #  li link_to("Edit entries", admin_clicks_lookup_table_clicks_lookup_path(clicks_lookup_table))
      #end
    end
  end

  index do
    column :click_description
    column :tier_label
    column :color_range_start
    column :color_range_end
    column :black
    column :volume_range_start
    column :volume_range_end
    column :price
    default_actions
  end

  show do |press|
    attributes_table do
      row :click_description
      row :tier_label
      row :color_range_start
      row :color_range_end
      row :black
      row :volume_range_start
      row :volume_range_end
      row :price
    end
  end

  filter :click_description

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :click_description, :label => "Click Description"
      f.input :tier_label, :label => "Tier Label"
      f.input :color_range_start, :as => :select, :collection => ["0", "1", "2", "3", "4", "5", "6"], :label => "Color Range Start"
      f.input :color_range_end, :as => :select, :collection => ["0", "1", "2", "3", "4", "5", "6"], :label => "Color Range End"
      f.input :black, :as => :radio, :collection => {"Yes" => 1, "No" => 0}, :label => "Black"
      f.input :volume_range_start, :as => :number, :min => 0, :label => "Volume Range Start"
      f.input :volume_range_end, :as => :number, :min => 0, :label => "Volume Range End"
      f.input :price, :as => :number, :min => 0, :label => "Price (USD)"
    end

    f.buttons
  end
end


