ActiveAdmin.register PressType do

  config.clear_sidebar_sections!

  index do
    column("Name") {|press_type| link_to press_type.name, admin_press_type_path(press_type.id) }
    column "Duty Cycle (clicks/mth)", :duty_cycle
    column :icon do |press|
      image_tag(press.icon.url(:small)) if press.icon.present?
    end
    column "SPI (USD)", :spi do |press|
      number_to_currency press.spi
    end
    column :click_table
    #default_actions
  end

  show :title => :name do |press|
    attributes_table do
      row :name
      row :duty_cycle
      row :icon do
        image_tag(press.icon.url(:medium)) if press.icon.present?
      end
      row "SPI (USD)", :spi do |press|
        number_to_currency press.spi
      end
      row :click_table
      em { link_to "View All Press Types", admin_press_types_path() }
    end


    panel "Impositions" do
      table_for(Imposition.find_all_by_press_type_id(press_type.id)) do
        column :job_size
        column :ups
      end
    end

  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :duty_cycle, :label => "Duty Cycle", :hint => 'max clicks per month'

      if f.object.icon.present?
        f.input :icon, :as => :file, :hint => f.template.image_tag(f.object.icon.url(:medium))
      else
        f.input :icon, :as => :file
      end

      f.input :spi, :label => "SPI", :hint => "(USD per month)"
      f.input :click_table, :as => :select, :collection => ClickTable.all
    end
    f.buttons
  end
end

