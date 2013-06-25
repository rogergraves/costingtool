class RoiController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @press_types =  PressType.all || []
      @jobs = current_user.jobs || []
      @press_jobs = PressJob.get_press_jobs(current_user)
      @press_job_ids = PressJob.get_ids(@press_jobs)
      @presses = current_user.press_types
      @roi_costs = PressJob.get_roi_costs(@press_jobs)
      @roi_revenue = PressJob.get_roi_revenue(@press_jobs)
    end

  end
end
