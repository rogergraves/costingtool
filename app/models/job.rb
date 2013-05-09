class Job < ActiveRecord::Base
  attr_accessible :name, :pages_per_month, :number_of_jobs, :copies_per_job, :multicolor_clicks, :black,
                  :number_of_pages, :plex, :sale_price, :annual_growth, :job_percentage
  belongs_to :user

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

  validates_numericality_of :number_of_pages

end


