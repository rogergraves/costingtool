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
    puts "!!!!! calculated_clicks_cost run for #{self.id}, click_price: #{click_price}, number_of_sheets: #{number_of_sheets}, plex: #{plex} !!!!!!!!!!!!!!!!!!!!"
    click_price * number_of_sheets * plex
  end

  def calculated_total_cost
    (press_cost || 0.0) + (calculated_media_cost || 0.0) + (labor_cost || 0.0) + (spi_cost || 0.0) + (calculated_clicks_cost || 0.0)
  end

  def calculated_cost_per_copy
    calculated_total_cost / copies_per_month
  end

  def calculated_cost_per_job
    calculated_total_cost / number_of_jobs
  end

  # Reports graph output ---------------------------------------------------------------------------------------

  def dashboard_graph_costs
    graph_data = []
    last_year_aggregated_job_monthly_cost = aggregated_job_monthly_cost
    (1..7).each do |year|
      last_year_aggregated_job_monthly_cost = last_year_aggregated_job_monthly_cost + (last_year_aggregated_job_monthly_cost * annual_growth / 100) if year > 1
      graph_data << [year, last_year_aggregated_job_monthly_cost.to_i]
    end

    return graph_data.to_s
  end

  def dashboard_graph_revenue
    graph_data = []
    press_jobs_last_year_revenues = []
    press_type_press_jobs.each_with_index do |pj, index|
      press_jobs_last_year_revenues[index] = pj.annual_revenue
    end


    (1..7).each do |year|
      if year > 1
        press_type_press_jobs.each_with_index do |pj, index|
          press_jobs_last_year_revenues[index]*= (1 + pj.annual_growth.to_f / 100)
        end

      end

      sum_of_last_year_revenues = 0
      press_jobs_last_year_revenues.each_with_index do |revenue, index|
        sum_of_last_year_revenues+= revenue
      end

      graph_data << [year, sum_of_last_year_revenues.round()]
    end

    return graph_data.to_s
  end

  # Calcs Support Methods --------------------------------------------------------------------------------------

  def press_type_press_jobs
    @press_type_press_jobs ||= press_type_press_jobs!
  end

  def press_type_press_jobs!
    valid_press_jobs = []
    self.job.user.jobs.each do |this_job|
      this_job.press_jobs.each do |this_press_job|
        valid_press_jobs << this_press_job if this_press_job.press_type == self.press_type
      end
    end

    valid_press_jobs
  end

  def sum_costs
    @sum_costs ||= sum_costs!
  end

  def sum_revenues
    @sum_revenues ||= sum_revenues!
  end

  def net_profit
    @net_profit ||= (sum_revenues - sum_costs).round()
  end

  def press_roi
    revenues = 0
    costs = 0

    self.press_type_press_jobs.each do |pj|
      revenues+= pj.sum_revenues
      costs+= pj.sum_costs
    end

    (100*(revenues-costs)/revenues).round()
  end

  def press_payback_period
    revenues = 0
    profits = 0

    self.press_type_press_jobs.each do |pj|
      revenues+= pj.sum_revenues
      profits+= pj.net_profit
    end

    (12*(revenues / profits)).ceil
  end

  def press_total_profit
    profits = 0

    self.press_type_press_jobs.each do |pj|
      profits+= pj.net_profit
    end

    profits
  end

  def press_total_costs
    costs = 0
    self.press_type_press_jobs.each do |pj|
      costs+= pj.sum_costs
    end

    costs
  end

  def press_production_life
    @press_production_life ||= press_type.production_life_months
  end

  def annual_revenue
    @annual_revenue ||= monthly_revenue * 12
  end

  def monthly_revenue
    @monthly_revenue ||= number_of_jobs * sale_price
  end

  def sale_price
    @sale_price ||= self.job.sale_price
  end

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
    @plex ||= (self.job.plex == 'Duplex' ? 2.0 : 1.0)
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
    @ink_array ||= ink_array!
  end

  def tier
    @tier ||= tier!
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

  def self.get_ids(press_jobs)
    ids = []
    press_jobs.each {|press_job| ids << press_job.id}
    ids
  end

  def self.get_roi_costs(press_jobs)
    costs = {}
    press_jobs.each do |press_job|
      press_job_tag = "#{press_job.id}"
      costs[press_job_tag] = press_job.dashboard_graph_costs
    end
    costs
  end

  def self.get_roi_revenue(press_jobs)
    revenue = {}
    press_jobs.each do |press_job|
      press_job_tag = "#{press_job.id}"
      revenue[press_job_tag] = press_job.dashboard_graph_revenue
    end
    revenue
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
      has_job = true if job.press_jobs.length > 0
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

  def tier!
    if ink_array.present? && ink_array.tiers.present?
      ink_array.tiers.each do |tier|
        if tier.volume_range_start <= job_basket_pages_per_month
          if tier.volume_range_end.nil? || tier.volume_range_end.blank? || tier.volume_range_end >= job_basket_pages_per_month
            return tier
          end
        end
      end
    end

    return nil
  end

  def ink_array!
    if click_table.present? && click_table.ink_arrays.present?
      click_table.ink_arrays.each do |ink_array|
        if ink_array.color_range_start <= multicolor_clicks
          if ink_array.color_range_end.nil? || ink_array.color_range_end.blank? || (ink_array.color_range_end >= multicolor_clicks && ink_array.black == black)
            return ink_array
          end
        end
      end
    end

    return nil
  end

  def sum_costs!
    costs = 0
    last_year_costs = aggregated_job_monthly_cost
    (1..7).each do |year|
      last_year_costs = last_year_costs + (last_year_costs * annual_growth / 100) if year > 1
      costs+= last_year_costs
    end

    return costs.round()
  end

  def sum_revenues!
    revenues = 0
    last_year_revenues = annual_revenue
    (1..7).each do |year|
      last_year_revenues+= (last_year_revenues * annual_growth / 100) if year > 1
      revenues+= last_year_revenues
    end

    return revenues.round()
  end

  def total_profit!
    sum_revenues - sum_costs
  end
end
