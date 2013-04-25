ActiveAdmin.register User do
  index do
    column :email
    column :first_name
    column :last_name
    column :country
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  show do |ad|
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :country
      row :company
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end
end
