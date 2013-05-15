ActiveAdmin.register ClickTable do

  sidebar "Ink Arrays" do
    ul do
      #link_to 'Add an Ink Array', admin_click_table_ink_arrays_path(click_table.id)
    end
  end

  index do
    column :description
    default_actions
  end

  show do
    attributes_table do
      row :description
    end
  end

  form do |f|
    f.inputs "Click Table" do
      f.input :description
    end
    f.buttons
  end



  ActiveAdmin.register InkArray do
    belongs_to :click_table

    sidebar "Tiers" do
      ul do
        #link_to 'Add a Tier to this Ink Array', admin_ink_array_tiers_path(ink_array.id)
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

  end
end

