ActiveAdmin.register ClickTable do

  sidebar "Links", :only => :show do
    ul do
      li link_to "See All Click Tables", admin_click_tables_path()
      li link_to "Create a New Click Table", new_admin_click_table_path()
      li link_to "Add an Ink Array", new_admin_click_table_ink_array_path(click_table.id)
      #li link_to "Add a New Tier", admin_click_table_ink_arrays_path(click_table.id)
    end
  end

  filter :click_table
  filter :ink_array
  filter :tier

  index do
    selectable_column
    column :click_table_name, :label => "Name"
    column :description
    default_actions
  end

  form do |f|
    f.inputs "Click Table" do
      f.input :click_table_name, :label => "Name"
      f.input :description
    end
    f.buttons
  end

  show do
    attributes_table do
      row :click_table_name, :label => "Name"
      row :description
    end

    panel "Ink Arrays" do
      table_for(InkArray.find_all_by_click_table_id(click_table.id)) do
        column(:description) {|ink_array| link_to ink_array.description, edit_admin_click_table_ink_array_path(ink_array.click_table_id, ink_array.id) }
        #column :description, :label => 'Ink Levels'
        column :color_range_start
        column :color_range_end
        column :black
        end
        #button link_to "New", new_admin_click_table_ink_array
    end

  end

  #def inkarrays_by_ctid
  #  InkArray.find_all_by_click_table_id(click_table.id)
  #end
  #
  #def tiers_by_iaid
  #  Tier.find_all_by_ink_array_id(InkArray.find_all_by_click_table_id(click_table.id))
  #  #trying to find all tiers for all ink arrays for this click_table id ()
  #end


end

