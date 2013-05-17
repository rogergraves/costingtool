class Job < ActiveRecord::Base
  attr_accessible :name, :pages_per_month, :number_of_jobs, :copies_per_job, :multicolor_clicks, :black,
                  :number_of_pages, :plex, :sale_price, :annual_growth, :job_percentage, :job_size

  AVAILABLE_SIZES = ['6"x9"', '7"x10"', 'A5', 'A4', 'A3', 'B2']

  validates_inclusion_of :job_size, :in => AVAILABLE_SIZES

  belongs_to :user
  has_many :press_jobs

  before_save :translate_form_inputs

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
      :pages_per_month => :integer,
      :number_of_jobs => :integer,
      :copies_per_job => :integer,
      :job_size => :string,
      :multicolor_clicks => :integer,
      :black => :integer,
      :number_of_pages => :integer,
      :plex => :integer,
      :sale_price => :integer,
      :annual_growth => :integer,
      :job_percentage => :integer
  }

  validates_numericality_of :number_of_jobs, :copies_per_job

  def translate_form_inputs
    self.black ? self.black = 1 : self.black = 0
    self.data["plex"] == "Duplex" ? self.plex = 2 : self.plex = 1
  end

  def self.available_sizes
    AVAILABLE_SIZES.to_a
  end

  def css_name
    self.name.downcase.split(" ").join("-")
  end

end


