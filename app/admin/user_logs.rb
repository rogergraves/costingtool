ActiveAdmin.register UserLog do

  index do
    column :user
    column :action
    column :created_at, :label => "Time / Date"
  end


end

