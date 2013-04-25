class ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    super if resource.nil? or resource.confirmed?
  end

  def confirm
    Rails.logger.info("resource_name: #{resource_name}")
    Rails.logger.info("resource_class: #{resource_class}")
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token]) if params[resource_name][:confirmation_token].present?
    Rails.logger.info("resource: #{resource}")
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      set_flash_message :notice, :confirmed
      sign_in_and_redirect(resource_name, resource)
    else
      render :action => "show"
    end
  end
end