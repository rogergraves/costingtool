ActiveAdmin.register Tier do
  belongs_to :ink_array

  filter false

  breadcrumb do
    [ link_to("ADMIN", '/admin'), link_to(ink_array.click_table.name, admin_click_table_path(ink_array.click_table_id)), link_to(ink_array.name, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id)) ]
  end

  index do
    column :ink_array
    column("Tier Level", :sort_by => :name ) {|tier| link_to tier.name, admin_ink_array_tier_path(tier.ink_array_id,
                                                                                                tier.id) }
    column :volume_range_start
    column :volume_range_end
    column :price
    if ink_array.black > 0
      column :black_price, :label => "Price: Black"
      end
  end

  show :title => :name do
    attributes_table do
      row("Ink Array") {|tier| link_to tier.ink_array.name, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
      row :name, :label => "Tier Level"
      row :volume_range_start
      row :volume_range_end
      row :price
      if ink_array.black > 0
        row :black_price, :label => "Price: Black"
      end
      em { link_to "Back to View All (#{ink_array.name})", admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
    end
  end

  form do |f|
    f.inputs "Tier" do
      f.input :ink_array, :disabled => true
      f.input :name, :label => "Tier Level"
      f.input :volume_range_start, :label => "Volume Range Start"
      f.input :volume_range_end, :label => "Volume Range End"
      f.input :price
      if ink_array.black > 0
        f.input :black_price, :label => "Price: Black"
      end
    end
    f.buttons
    end
  end

