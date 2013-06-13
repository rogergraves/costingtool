class PressJob < ActiveRecord::Base
  attr_accessible :job_id, :press_type_id, :media_cost, :labor_cost, :spi_cost, :clicks_cost, :press_type, :cost_per_sheet, :click_price, :press_price
  belongs_to :job
  belongs_to :press_type

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :media_cost => :float,
      :clicks_cost => :float,
  }

  # Calculations -----------------------------------------------------------------------------------------

  def calculated_media_cost # :media_cost
    @calculated_media_cost ||= cost_per_sheet * plex * number_of_pages * copies_per_month / ups
  end

  def calculated_spi_cost # :spi_cost
    @calculated_spi_cost ||= self.press_type.spi
  end

  def calculated_clicks_cost # :clicks_cost
    click_price * number_of_sheets * plex
  end

  def calculated_total_cost
    (press_cost || 0.0) + (calculated_media_cost || 0.0) + (labor_cost || 0.0) + (spi_cost || 0.0) + (calculated_clicks_cost || 0.0)
  end

  def calculated_cost_per_copy
    calculated_total_cost / copies_per_month
  end

  def calculated_cost_per_job
    calculated_cost_per_copy / number_of_jobs
  end

  # Reports graph output ---------------------------------------------------------------------------------------

  def dashboard_graph_costs
    [[1, 1450487], [2, 1537516], [3, 1629767], [4, 1727553], [5, 1831206], [6, 1941078], [7, 2057543]].to_s
  end

  def dashboard_graph_revenue
    [[1, 685946], [2, 816276], [3, 971369], [4, 1155929], [5, 1375556], [6, 1636911], [7, 1941078]].to_s
  end

  # Calcs Support Methods --------------------------------------------------------------------------------------

  def aggregated_job_monthly_cost
    @aggregated_job_monthly_cost ||= (calculated_total_cost - press_cost - self[:spi_cost])
  end

  def press_cost
    @press_cost ||= self[:press_price]/60
  end

  def spi_investment
    @spi_investment ||= self[:spi_cost] * 7 * 12
  end

  def annual_growth
    @annual_growth ||= self.job.annual_growth
  end

  def click_price
    self[:click_price] || ((black_tier_price * black) + (color_tier_price * multicolor_clicks))
  end

  def click_price= val
    self[:click_price] =  val
  end

  def cost_per_sheet
    self[:cost_per_sheet] || Media.find_by_name(job_size).cost_per_sheet
  end

  def cost_per_sheet= val
    self[:cost_per_sheet] = val
  end

  def number_of_pages
    @number_of_pages ||= self.job.number_of_pages
  end

  def copies_per_month
    @copies_per_month ||= number_of_jobs * copies_per_job
  end

  def number_of_jobs
    @number_of_jobs ||= self.job.number_of_jobs
  end

  def copies_per_job
    @copies_per_job ||= self.job.copies_per_job
  end

  def ups
    @ups ||= self.press_type.impositions.find_by_job_size(job_size).ups
  end

  def pages_per_month
    @pages_per_month ||= self.job.pages_per_month
  end

  def plex
    @plex ||= self.job.plex
  end

  def job_size
    @job_size ||= self.job.job_size
  end

  def job_basket_pages_per_month
    @job_basket_pages_per_month ||= user_jobs_pages_per_month
  end

  def user_jobs_pages_per_month
    total = 0
    self.job.user.jobs.each do |job|
      total += job.pages_per_month
    end

    total
  end

  def click_table
    @click_table ||= self.press_type.click_table
  end

  def ink_array
    @ink_array ||= calculate_ink_array
  end

  def tier
    @tier ||= calculate_tier
  end

  def color_tier_price
    return 0.00 if tier.nil?
    @color_tier_price ||= (tier.price || 0.00)
  end

  def black_tier_price
    return 0.00 if tier.nil?
    @black_tier_price ||= (tier.black_price || 0.00)
  end

  def multicolor_clicks
    @multicolor_clicks ||= self.job.multicolor_clicks
  end

  def black
    @black ||= self.job.black
  end

  def number_of_sheets
    @number_of_sheets ||= (number_of_pages * number_of_jobs * copies_per_job / ups).ceil
  end

# Class methods -----------------------------------------------------------------------------------------

  def self.clean_for_user(user)
    user.jobs.each do |job|
      job.press_jobs.destroy_all
    end
  end

  def self.get_presses(params, user)
    presses = params["presses"].split(',')
    user.current_step = "third"
    user.presses = presses
    user.save!
  end

  def self.generate_press_jobs(jobs, presses)
    jobs.each do |job|
      presses.each do |press|
        new_press_job = job.press_jobs.create(:press_type => press)
        new_press_job.media_cost  = new_press_job.calculated_media_cost
        new_press_job.clicks_cost  = new_press_job.calculated_clicks_cost
        new_press_job.spi_cost  = new_press_job.calculated_spi_cost
        new_press_job.labor_cost = (press.labor || 0.0)
        new_press_job.press_price = (press.price || 0.0)
        new_press_job.save!
      end
    end
  end

  def self.oldest(press_jobs)
    oldie = nil
    press_jobs.each do |press_job|
      oldie ||= press_job
      oldie = press_job if oldie.created_at < press_job.created_at
    end
    oldie
  end

  def self.newest(press_jobs)
    baby = nil
    press_jobs.each do |press_job|
      baby ||= press_job
      baby = press_job if baby.created_at > press_job.created_at
    end
    baby
  end

  def self.has_press_jobs(jobs)
    has_job = false
    jobs.each do |job|
      has_job = true if job.press_jobs.length > 1
    end
    has_job
  end

  def self.get_press_jobs(user)
    press_jobs = []
    user.jobs.each {|job| press_jobs << job.press_jobs}
    press_jobs.flatten
  end

  def self.propagate_changes(user)
    press_jobs = self.get_press_jobs(user)
    Rails.logger.info("press_jobs: #{press_jobs}")
    first_job = user.jobs.first
    first_jobs_newest_press_job = self.newest(first_job.press_jobs)
    first_jobs_oldest_press_job = self.oldest(first_job.press_jobs)
    press_jobs.each do |press_job|
      Rails.logger.info("press_job: #{press_job}")
      Rails.logger.info("press_job.job: #{press_job.job}")
      if press_job.job != first_job
        job = press_job.job
        newest_press_job = self.newest(job.press_jobs)
        newest_press_job.update_attributes(
            :press_price => first_jobs_newest_press_job.press_price,
            :labor_cost => first_jobs_newest_press_job.labor_cost,
            :spi_cost => first_jobs_newest_press_job.spi_cost
        )
        oldest_press_job = self.oldest(job.press_jobs)
        oldest_press_job.update_attributes(
            :press_price => first_jobs_oldest_press_job.press_price,
            :labor_cost => first_jobs_oldest_press_job.labor_cost,
            :spi_cost => first_jobs_oldest_press_job.spi_cost
        )
      end
    end
  end


  # ------------------------------------------------------------------------------------------------------------------
  private

  def calculate_tier
    valid_tier = nil
    ink_array.tiers.each do |tier|
      if tier.volume_range_start <= job_basket_pages_per_month
        if tier.volume_range_end.nil? || tier.volume_range_end.blank? || tier.volume_range_end >= job_basket_pages_per_month
          valid_tier = tier
          break
        end
      end
    end
    valid_tier = valid_tier || ink_array.tiers.first

    valid_tier
  end

  def calculate_ink_array
    valid_ink_array = nil

    click_table.ink_arrays.each do |ink_array|
      if ink_array.color_range_start <= multicolor_clicks
        if ink_array.color_range_end.nil? || ink_array.color_range_end.blank? || ink_array.color_range_end >= multicolor_clicks && ink_array.black == black
          valid_ink_array = ink_array
          break
        end
      end
    end

    valid_ink_array = valid_ink_array ||  click_table.ink_arrays.first

    valid_ink_array
  end

end
