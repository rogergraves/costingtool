ActiveAdmin.register PressType do

  index do
    column :name
    column "Duty Cycle (clicks/mth)", :duty_cycle
    column :icon do |press|
      image_tag(press.icon.url(:small)) if press.icon.present?
    end
    column "SPI (USD)", :spi do |press|
      number_to_currency press.spi
    end
    column :click_table

    default_actions
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
    end
  end

  filter :name

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :duty_cycle, :label => "Duty cycle (max clicks per month)"

      if f.object.icon.present?
        f.input :icon, :as => :file, :hint => f.template.image_tag(f.object.icon.url(:medium))
      else
        f.input :icon, :as => :file
      end

      f.input :spi, :label => "SPI (USD per month) $"
      f.input :click_table, :as => :select, :collection => ClickTable.all
    end
    f.buttons
  end
end
