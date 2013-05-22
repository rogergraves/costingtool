class PressJobsController < InheritedResources::Base
  def new
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @press_job = Job.new
      @presses =  PressType.all || []
      @jobs = current_user.jobs || []
    end
  end

  def index
    @press_job = Job.new
    @presses =  PressType.all || []
    @jobs = current_user.jobs || []
  end

  def log_presses
    if user_signed_in?
      Rails.logger.info("params: #{params}")
      respond_to do |format|
        format.js do
          PressJob.get_presses(params, current_user)
          Rails.logger.info("presses: #{current_user.presses}")
          render :nothing => true, :status => 200
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

end