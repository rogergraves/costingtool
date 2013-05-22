ActiveAdmin.register Tier do
  belongs_to :ink_array

  breadcrumb do
    [
        link_to("ADMIN", '/admin'), link_to(ink_array.click_table.display_name, admin_click_table_path(ink_array.click_table_id)), link_to(ink_array.description, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id)), tier.label
    ]
  end

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

  show :title => :label do
    attributes_table do
      #row :click_table
      row("Ink Array") {|tier| link_to tier.ink_array.description, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
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
