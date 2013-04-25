ActiveAdmin.register PressType do
  index do
    column :name
    column :duty_cycle
    column :icon do |press|
      image_tag(press.icon.url(:small))
    end
    default_actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :duty_cycle
      row :icon do
        image_tag(ad.icon.url(:medium))
      end
    end
  end

  filter :name

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Details" do
      f.input :name
      f.input :duty_cycle

      if f.object.icon.present?
        f.input :icon, :as => :file, :hint => f.template.image_tag(f.object.icon.url(:medium))
      else
        f.input :icon, :as => :file
      end

    end
    f.buttons
  end
end
