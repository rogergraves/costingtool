ActiveAdmin.register AdminUser do
    menu :parent => "Setup", :priority => 4
    config.clear_sidebar_sections!

  index do                            
    selectable_column
    column("email"){ |email| link_to email.email, edit_admin_admin_user_path(email.id)}
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count
    #default_actions
  end                                 

    show do
      attributes_table do
        row :email
        row :current_sign_in_at
        row :last_sign_in_at
        row :sign_in_count
        end
        strong em { link_to "Update Administrator", edit_admin_admin_user_path(admin_user.id)}
      end

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do
      f.input :email
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
