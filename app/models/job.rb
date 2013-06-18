class Job < ActiveRecord::Base
  attr_accessible :name, :number_of_jobs, :copies_per_job, :multicolor_clicks, :black,
                  :number_of_pages, :plex, :sale_price, :annual_growth, :job_percentage, :job_size

  AVAILABLE_SIZES = ['6"x9"', '7"x10"', 'A5', 'A4', 'A3', 'B2']

  validates_inclusion_of :job_size, :in => AVAILABLE_SIZES

  belongs_to :user
  has_many :press_jobs, :dependent => :destroy

  after_save :translate_form_inputs

  serialize :data, ActiveRecord::Coders::Hstore
  hstore :data, :accessors => {
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

  validates_numericality_of :number_of_jobs, :copies_per_job, :multicolor_clicks, :number_of_pages, :sale_price, :annual_growth, :job_percentage

  def translate_form_inputs
    if self.data["black"] == "off" || self.data["black"] == nil
      self.data["black"] = 0
      self.save
    elsif data["black"] == "on"
      self.data["black"] = 1
      self.save
    else
    end

    self.data["plex"] == "Duplex" ? self.plex = 2 : self.plex = 1
  end

  def self.available_sizes
    AVAILABLE_SIZES.to_a
  end

  def css_name
    self.name.downcase.split(" ").join("-").sub(/\W/, '')
  end

  def copies_per_month
    self.number_of_jobs * self.copies_per_job
  end

  def pages_per_month
    copies_per_month * self.number_of_pages
  end

end


