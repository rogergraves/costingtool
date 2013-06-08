ActiveAdmin.register_page "Dashboard" do

  menu false
  #:priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

  # BUGBUG -- Elena, these changes were killing my admin on local so I'm commenting them out for now.
  #menu :priority => 0
  #
  #content :title => "Indigo ROI Admin" do
  #  div :class => "blank_slate_container" do
  #    #span :class => "blank_slate" do
  #      #span I18n.t("active_admin.dashboard_welcome.welcome")
  #      #small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #    #end
  #  end
  #
  #
  #columns do
  #  column do
  #    panel "Press" do
  #      table_for(PressType.all) do
  #        column :icon do |press|
  #          image_tag(press.icon.url(:small)) if press.icon.present?
  #        end
  #        column("Name") { |press_type| link_to press_type.name, admin_press_type_path(press_type.id) }
  #        column :click_table
  #      end
  #      strong em { link_to "Add New Press Type", new_admin_press_type_path() }
  #    end
  #  end
  #
  #  column do
  #    panel "Media" do
  #      table_for(Media.all) do
  #        #column :name
  #        column("Name") { |media| link_to media.name, admin_medium_path(media.id) }
  #        column :cost_per_sheet
  #      end
  #      strong em { link_to "Add New Media", new_admin_medium_path() }
  #    end
  #  end
  #end
  #
  #  columns do
  #    column do
  #      panel "Click Tables" do
  #        table_for(ClickTable.all) do
  #          column("Name") { |click_table| link_to click_table.name, admin_click_table_path(click_table.id) }
  #          column :description
  #        end
  #        strong em { link_to "Add New Click Table", new_admin_click_table_path() }
  #      end
  #    end
  #  end
  #
  #
  #columns do
  #  column do
  #    panel "Ink Array" do
  #      table_for(InkArray.all) do
  #        column("Name") { |ink_array| link_to ink_array.name, admin_click_table_ink_arrays_path(ink_array.id) }
  #        column :click_table
  #        column :black do |value|
  #          value.black == 0 ? "No" : "Yes"
  #        end
  #      end
  #    end
  #  end
  #
  #  column do
  #    panel "Tiers" do
  #      table_for(Tier.all) do
  #        column("Name") { |tier| link_to tier.name, admin_ink_array_tier_path(tier.ink_array_id, tier.id) }
  #        column("Ink Array") { |tier_ink_array| link_to tier_ink_array.ink_array.name, admin_click_table_ink_arrays_path(tier_ink_array.ink_array_id) }
  #      end
  #    end
  #  end
  #
  #
  #end





    #  column :job_size
    #  column :ups
    #end
    #strong em { link_to 'Create New Imposition', new_admin_imposition_path() }

#      panel "Ink Arrays" do
#        table_for(InkArray.all) do
#          column(:name) { |ink_array| link_to ink_array.name, admin_click_table_ink_array_path(ink_array.id) }
#          #column :color_range_start
#          #column :color_range_end
#          column :black do |value|
#            value.black == 0 ? "No" : "Yes"
#          end
#        end
#        strong em { link_to "Add an Ink Array", new_admin_click_table_ink_array_path(click_table.id) }
#      end
#    end
#
#    #   column do
#    #     panel "Info" do
#    #       para "Welcome to ActiveAdmin."
#    #     end
#    #   end
#    # end

    #end # content
  end
end


