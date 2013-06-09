ActiveAdmin.register_page "Dashboard" do

  menu :priority => 0

  # Leave lines 6 - 12 in the code as the dashboard doesn't work without them...
  content :title => "Indigo ROI Overview" do

    columns do
      column :span => 4 do
        panel "Press Types" do
          table_for(PressType.all) do
            column :icon do |press|
              image_tag(press.icon.url(:small)) if press.icon.present?
            end
            column("Name") { |press_type| link_to press_type.name, admin_press_type_path(press_type.id) }
            column "Total Press Price (USD)", :price do |press|
              number_to_currency press.price
            end
            column :click_table
          end
          strong em { link_to "Add New Press Type", new_admin_press_type_path() }
        end
      end

      column :span => 2 do
        panel "Media Costs" do
          table_for(Media.all) do
            column ("Name") { |media| link_to media.name, admin_medium_path(media.id) }
            column :cost_per_sheet do |media|
              number_to_currency media.cost_per_sheet
            end
          end
          strong em { link_to "Add New Media", new_admin_medium_path() }
        end
      end
    end

      columns do
        column do
          panel "Click Tables" do
            table_for(ClickTable.all) do
              column("Name") { |click_table| link_to click_table.name, admin_click_table_path(click_table.id) }
              column :description
            end
            strong em { link_to "Add New Click Table", new_admin_click_table_path() }
          end
        end
      end


    columns do
      column do
        panel "Ink Arrays" do
          table_for(InkArray.all) do
            column("Name") { |ink_array| link_to ink_array.name, admin_click_table_ink_arrays_path(ink_array.id) }
            column :click_table
            column :color_range_start
            column :color_range_end
            column :black do |value|
              value.black == 0 ? "No" : "Yes"
            end
          end
        end
      end

      column do
        panel "Tiers" do
          table_for(Tier.all) do
            column("Ink Array") { |tier| link_to tier.ink_array.name, admin_click_table_ink_arrays_path(tier.ink_array_id) if tier.ink_array.present? }
            column("Name") { |tier| link_to tier.name, admin_ink_array_tier_path(tier.ink_array_id, tier.id) if tier.ink_array.present? }
            column :price do |tier|
              number_to_currency tier.price
            end
            column "Black", :black_price do |tier|
              number_to_currency tier.black_price
            end
          end
        end
      end
    end
  end
end


