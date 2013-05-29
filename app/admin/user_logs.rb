ActiveAdmin.register UserLog do
    menu :parent => "Setup", :priority => 3

    #config.clear_action_items!
    actions :all, :except => [:new]

  index do
    column :user
    column :action
    column :created_at, :label => "Time / Date"
  end


end

