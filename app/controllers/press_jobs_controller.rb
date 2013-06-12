class PressJobsController < InheritedResources::Base
  def new
    PressJob.clean_for_user(current_user)

    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @press_job = Job.new
      @presses =  PressType.all || []
      @jobs = current_user.jobs || []
    end
  end

  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @press_types =  PressType.all || []
      @jobs = current_user.jobs || []
      current_user.press_types
      @presses = current_user.press_types
      @press_jobs = PressJob.generate_press_jobs(@jobs, @presses) if !PressJob.has_press_jobs(@jobs)
    end
  end

  def update
    @press_job = PressJob.find(params[:id])
    if user_signed_in?
      respond_to do |format|
        format.js do
          if @press_job.update_attributes(params[:press_job])
            PressJob.propagate_changes(current_user)
            render :nothing => true, :status => 200
          end
        end
      end
    else
      redirect_to new_user_session_path
    end
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
