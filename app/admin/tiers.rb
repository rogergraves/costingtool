ActiveAdmin.register Tier do
  belongs_to :ink_array

  index do
    column :ink_array_id
    column :label, :label => 'Tier Label'
    column :volume_range_start
    column :volume_range_end, :integer
    column :price, :float
    default_actions
  end

  show do
    attributes_table do
      row :ink_array_id
      row :label
      row :volume_range_start
      row :volume_range_end
      row :price
    end
  end

  form do |f|
    f.inputs "Tier" do
      f.input :label, :label => 'Tier Label'
      f.input :volume_range_start
      f.input :volume_range_end
      f.input :price
    end
    f.buttons
  end
end
