ActiveAdmin.register ClicksLookupTable do
  sidebar "Clicks Lookup Entries" do
    ul do
      li link_to("Create entries", new_admin_clicks_lookup_table_clicks_lookup_path(clicks_lookup_table))

      if clicks_lookup_table.clicks_lookups.present?
        li link_to("Edit entries", admin_clicks_lookup_table_clicks_lookup_path(clicks_lookup_table))
      end
    end
  end

  index do
    column :description

    default_actions
  end

  show do |press|
    attributes_table do
      row :description
    end
  end

  filter :description

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :description
    end

    f.buttons
  end
end
