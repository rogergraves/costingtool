ActiveAdmin.register Tier do
  belongs_to :ink_array

  index do
    selectable_column
    #column :click_table
    column :ink_array
    column :label, :label => 'Tier Label'
    column :volume_range_start
    column :volume_range_end
    column :price
    default_actions
  end

  show do
    attributes_table do
      #row :click_table
      row :ink_array_id
      row :label
      row :volume_range_start
      row :volume_range_end
      row :price
    end
  end

  form do |f|
    f.inputs "Tier" do
      f.input :ink_array, :as => :select, :collection => InkArray.all
      f.input :label, :label => 'Tier Label'
      f.input :volume_range_start
      f.input :volume_range_end
      f.input :price
    end
    f.buttons
  end
end
