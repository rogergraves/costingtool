class CostAnalysesController < InheritedResources::Base

  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @press_types =  PressType.all || []
      @jobs = current_user.jobs || []
      @presses = current_user.press_types
    end

  end

end