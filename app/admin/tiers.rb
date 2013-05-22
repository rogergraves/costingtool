ActiveAdmin.register Tier do
  belongs_to :ink_array

  breadcrumb do
    [ link_to("ADMIN", '/admin'), link_to(ink_array.click_table.display_name, admin_click_table_path(ink_array.click_table_id)), link_to(ink_array.description, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id)) ]
  end

  index do
    column :ink_array
    column("Tier Level", :sort_by => :label ) {|tier| link_to tier.label, admin_ink_array_tier_path(tier.ink_array_id, tier.id) }
    column :volume_range_start
    column :volume_range_end
    column :price
    if ink_array.black > 0
      column :black_price
      end
  end

  show :title => :label do
    attributes_table do
      row("Ink Array") {|tier| link_to tier.ink_array.description, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
      row :label
      row :volume_range_start
      row :volume_range_end
      row :price
      if ink_array.black > 0
        row :black_price
      end
      em { link_to "Back to View All (#{ink_array.description})", admin_click_table_ink_array_path(ink_array
                                                                                               .click_table_id,
                                                                               ink_array.id) }
    end
  end

  form do |f|
    f.inputs "Tier" do
      f.input :ink_array, :as => :select, :collection => InkArray.all
      f.input :label, :label => 'Tier Label'
      f.input :volume_range_start
      f.input :volume_range_end
      f.input :price
      if ink_array.black > 0
        f.input :black_price
      end
    end
    f.buttons
    end
  end

