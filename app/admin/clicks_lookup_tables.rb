ActiveAdmin.register ClicksLookupTable do

  #    :description => :string,        # Description of number of color channels
  #    :label => :string,              # Tier label, not :nil
  #    :color_range_start => :integer, # must be between 0-6, not :nil
  #    :color_range_end => :integer,   # greater than or equal to start, between 0-6, not :nil
  #    :black => :integer,             # 0 or 1, not :nil
  #    :volume_range_start => :integer,# greater than 0
  #    :volume_range_end => :integer,  # greater than or equal to start, nil = 0
  #    :price => :integer
  
  index do
    column :description
    #column :label
    #column :color_range_start
    #column :color_range_end
    #column :black
    #column :volume_range_start
    #column :volume_range_end
    #column :price

    default_actions
  end

  show do |press|
    attributes_table do
      row :description
      #row :label
      #row :color_range_start
      #row :color_range_end
      #row :black
      #row :volume_range_start
      #row :volume_range_end
      #row :price
    end
  end

  filter :description

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :description
      #f.input :label
      #f.input :color_range_start
      #f.input :color_range_end
      #f.input :black
      #f.input :volume_range_start
      #f.input :volume_range_end
      #f.input :price
    end

    f.buttons
  end
end
