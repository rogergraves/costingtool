ActiveAdmin.register ClicksLookup do
  belongs_to :clicks_lookup_table
  navigation_menu :clicks_lookup_table

  index do |entry|
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

  show do |entry|
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

  filter :description

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
