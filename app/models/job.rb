class Job < ActiveRecord::Base
  attr_accessible :name, :pages_per_month, :number_of_jobs, :copies_per_job, :multicolor_clicks, :black,
                  :number_of_pages, :plex, :sale_price, :annual_growth, :job_percentage
  belongs_to :user
  before_save :translate_form_inputs

  serialize :data, ActiveRecord::Coders::Hstore
  #HSTORE_ATTR_NAMESPACE = 'attribute'
  hstore :data, :accessors => {
      "pages_per_month" => :integer,
      "number_of_jobs" => :integer,
      "copies_per_job" => :integer,
      "multicolor_clicks" => :integer,
      "black" => :integer,
      "number_of_pages" => :integer,
      "plex" => :integer,
      "sale_price" => :integer,
      "annual_growth" => :integer,
      "job_percentage" => :integer
  }

  validates_numericality_of :number_of_jobs, :copies_per_job

  def translate_form_inputs
    Rails.logger.info("plex = #{self.data["plex"]}")
    Rails.logger.info("self = #{self.ai}")
    self.black ? self.black = 1 : self.black = 0
    self.data["plex"] == "Duplex" ? self.plex = 2 : self.plex = 1
  end

end


