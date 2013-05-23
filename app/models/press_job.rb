class PressJob < ActiveRecord::Base
  attr_accessible :job_id, :press_type_id, :press_cost, :media_cost, :labor_cost, :spi_cost, :clicks_cost, :press_type
  belongs_to :job
  belongs_to :press_type

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :press_cost => :float,
      :media_cost => :float,
      :labor_cost => :float,
      :spi_cost => :float,
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
    ((black_tier_price * black) + (color_tier_price * multicolor_clicks)) * number_of_sheets * plex
  end


  # Support Methods --------------------------------------------------------------------------------------

  def cost_per_sheet
    @cost_per_sheet ||= Media.find_by_name(job_size).cost_per_sheet
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
    @color_tier_price ||= (tier.price || 0.00)
  end

  def black_tier_price
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

  def self.get_presses(params, user)
    presses = params["presses"].split('"')
    presses.each do |press|
      if press.length < 2
        presses.delete(press)
      end
    end
    user.current_step = "third"
    user.presses = presses
    user.save!
  end

  def self.generate_press_jobs(jobs, presses)
    jobs.each do |job|
      presses.each do |press|
        job.press_jobs.create(:press_type => press)
      end
    end
  end


  # ------------------------------------------------------------------------------------------------------------------
  private

  def calculate_tier
    valid_tier = nil
    ink_array.tiers.each do |tier|
      if tier.volume_range_start <= job_basket_pages_per_month && tier.volume_range_end >= job_basket_pages_per_month
        valid_tier = tier
        break
      end
    end

    valid_tier
  end

  def calculate_ink_array
    valid_ink_array = nil

    click_table.ink_arrays.each do |ink_array|
      if ink_array.color_range_start <= multicolor_clicks && ink_array.color_range_end >= multicolor_clicks && ink_array.black == black
        valid_ink_array = ink_array
        break
      end
    end

    valid_ink_array
  end


end
