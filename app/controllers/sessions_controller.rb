class SessionsController < Devise::SessionsController
  def create
    UserLog.create(:user_id => current_user.id, :action => "Login")
    super
  end

  def destroy
    UserLog.create(:user_id => current_user.id, :action => "Logout")
    super
  end
end
