ActiveAdmin.register InkArray do
  belongs_to :click_table

  config.clear_sidebar_sections!

  breadcrumb do
    [ link_to("ADMIN", '/admin'), link_to(click_table.name, admin_click_table_path(click_table.id)) ]
  end

  index do
    column("Ink Array") {|ink_array| link_to ink_array.name, admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
    column("for Click Table") {|clicktable| link_to click_table.name, admin_click_table_path(clicktable
                                                                                             .click_table_id) }
    column :color_range_start
    column :color_range_end
    column :black do |value|
      value.black == 0? "No" : "Yes"
    end
    default_actions
  end


  show do

    columns do

      column :span => 2 do
        attributes_table do
          row("Ink Array") { |ink_array| link_to ink_array.name, edit_admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
          row("Belongs to Click Table") { |clicktable| link_to click_table.name, admin_click_table_path(clicktable.click_table_id)}
          row :color_range_start
          row :color_range_end
          row :black do |value|
              value.black == 0 ? "No" : "Yes"
          end
        end
      end

      column :span => 4 do
        panel "Tiers" do
          table_for(Tier.find_all_by_ink_array_id(ink_array.id)) do
            column("Tier Level", :sort_by => :name) { |tier| link_to tier.name, admin_ink_array_tier_path(tier.ink_array_id, tier.id) }
            column :volume_range_start
            column :volume_range_end
            column :price
            if ink_array.black > 0
                column :black_price
            end
          end
            strong { link_to "Add New Tier", new_admin_ink_array_tier_path(ink_array.id) }
        end
      end

    end # columns

  end   # show

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Ink Array" do
      f.input :click_table, :as => :select, :collection => ClickTable.all, :include_blank => false
      f.input :name
      f.input :color_range_start, :as => :select, :collection => [0, 1, 2, 3, 4, 5, 6], :include_blank => false
      f.input :color_range_end, :as => :select, :collection => [0, 1, 2, 3, 4, 5, 6], :include_blank => false
      f.input :black, :as => :radio, :collection => { " No" => 0, " Yes" => 1 }
    end
      f.buttons
  end   # form

end
