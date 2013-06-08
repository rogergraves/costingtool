ActiveAdmin.register PressType, { :sort_order => :id_asc } do
    menu :parent => "Press Setup", :priority => 0

  config.clear_sidebar_sections!

  index do
    column :icon do |press|
      image_tag(press.icon.url(:small)) if press.icon.present?
    end
    column("Name"){|press_type| link_to press_type.name, admin_press_type_path(press_type.id) }
    column :price, :label => "Total Press Price", :hint => 'Total Press Cost in USD'
    column :labor, :label => "Labor costs", :hint => 'Monthly Labor in USD'
    column "Duty Cycle (clicks/mth)", :duty_cycle, :sortable => false
    column "SPI (USD)", :spi do |press|
      number_to_currency press.spi
    end
    column :click_table
    #default_actions
  end

  show :title => :name do |press|
    columns do
      column do
        attributes_table do
          row :name
          row :price, :label => "Total Press Price"
          row :labor, :label => "Labor costs"
          row :duty_cycle
          row "SPI (USD)", :spi do |press|
            number_to_currency press.spi
          end
          row :click_table
          row :icon do
            image_tag(press.icon.url(:medium)) if press.icon.present?
          end
          strong em { link_to "View All Press Types", admin_press_types_path() }
        end
      end

      column do
        panel "Impositions" do
          table_for(Imposition.find_all_by_press_type_id(press_type.id)) do
            column :job_size
            column :ups
          end
          strong em { link_to 'Create New Imposition', new_admin_imposition_path() }
        end
      end

    end # columns

  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :price, :label => "Total Press Price", :hint => 'Total Press Cost in USD'
      f.input :labor, :label => "Labor costs", :hint => 'Monthly Labor in USD'
      f.input :duty_cycle, :label => "Duty Cycle", :hint => 'max clicks per month'
      f.input :spi, :label => "SPI", :hint => "SPI in USD"
      f.input :click_table, :as => :select, :collection => ClickTable.all
      if f.object.icon.present?
        f.input :icon, :as => :file, :hint => f.template.image_tag(f.object.icon.url(:medium))
      else
        f.input :icon, :as => :file
      end
    end
    f.buttons
  end
end

