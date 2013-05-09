class JobsController < InheritedResources::Base

  def new
    if user_signed_in?
      @job = Job.new
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(params[:job])
      redirect_to jobs_path
    else
      redirect_to edit_job_path
    end
  end

  def create
    if user_signed_in?
      @job = current_user.jobs.build(params[:job])
      if @job.valid?
        @job.save
        respond_to do |format|
          format.html {
            redirect_to jobs_path
          }
          #format.js { render :template => 'links/create.js.erb', :layout => false }
        end
      else
        respond_to do |format|
          format.html {render action: "new"}
          format.json {render json: @job.errors,
                              status: unprocessable_entity}
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

  def index
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @job = Job.new
      Rails.logger.info("jobs: #{current_user.jobs}")
      @jobs = current_user.jobs || []
    end
  end

  def empty_basket
    if user_signed_in?
      current_user.jobs.each {|job| job.destroy }
    end
    redirect_to jobs_path
  end


end
