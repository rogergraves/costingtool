ActiveAdmin.register InkArray do
  belongs_to :click_table

  breadcrumb do
    [ link_to("ADMIN", '/admin'), link_to(click_table.click_table_name, admin_click_table_path(click_table.id)) ]
  end


  index do
    column("Ink Array Description") {|ink_array| link_to ink_array.description, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
    column("for Click Table") {|ct| link_to click_table.click_table_name, admin_click_table_path(ct.click_table_id)   }
    column :color_range_start
    column :color_range_end
    column :black do |value|
      value.black == 0? "No" : "Yes"
    end
    default_actions
  end


  show do

    attributes_table do
      row("Ink Array Description") {|ink_array| link_to ink_array.description, edit_admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
      row("Belongs to Click Table") {|ct| link_to click_table.click_table_name, admin_click_table_path(ct.click_table_id)   }
      row :color_range_start
      row :color_range_end
      row :black do |value|
        value.black == 0? "No" : "Yes"
      end
    end


    panel "Tiers" do
      table_for(Tier.find_all_by_ink_array_id(ink_array.id)) do
        column("Tier Level", :sort_by => :label ) {|tier| link_to tier.label, admin_ink_array_tier_path(tier.ink_array_id, tier.id) }
        column :volume_range_start
        column :volume_range_end
        column :price
        if ink_array.black > 0
          column :black_price
        end
      end
         strong{ link_to "Add New Tier", new_admin_ink_array_tier_path(ink_array.id)}
      end

  end

  form do |f|
    f.inputs "Ink Array" do
      f.input :click_table, :as => :select, :collection => ClickTable.all
      f.input :description
      f.input :color_range_start, :as => :select, :collection => [0, 1, 2, 3, 4, 5, 6]
      f.input :color_range_end, :as => :select, :collection => [0, 1, 2, 3, 4, 5, 6]
      f.input :black, :as => :radio, :collection => { " No" => 0, " Yes" => 1 }
    end
    f.buttons
  end

  #sidebar "Tiers", :only => :show do
  #  ul do
  #    button_to "Add New Tier", admin_ink_array_tiers_path(ink_array.id)
  #  end
  #end

end
