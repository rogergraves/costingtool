class PressJob < ActiveRecord::Base
  attr_accessible :job_id, :press_type_id, :press_cost, :media_cost, :labor_cost, :spi_cost, :clicks_cost
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

  def calculated_media_cost
    @calculated_media_cost ||= cost_per_sheet * plex * number_of_pages * copies_per_month / ups
  end

  def calculated_spi_cost
    @calculated_spi_cost ||= self.press_type.spi
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

  def calculate_ink_array
    click_table.ink_arrays.each do |ink_array|
      return ink_array if ink_array.color_range_start >= multicolor_clicks && ink_array.color_range_end <= multicolor_clicks && ink_array.black == black
    end
  end

  def calculated_clicks_cost
    0.00 # Still working on this...
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
end
