class DashboardsController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @press_types =  PressType.all || []
      @jobs = current_user.jobs || []
      @presses = current_user.press_types
      @press_jobs = PressJob.get_press_jobs(current_user)
      @press_job_ids = PressJob.get_ids(@press_jobs)
      @dashboard_costs = PressJob.get_dashboard_costs(@press_jobs)
      @dashboard_revenue = PressJob.get_dashboard_revenue(@press_jobs)
    end

  end
end
