class Job < ActiveRecord::Base
  attr_accessible :name, :run_length, :clicks, :book_size, :pages, :sale_price, :annual_growth, :job_percentage
  belongs_to :user

  serialize :data, ActiveRecord::Coders::Hstore
  #HSTORE_ATTR_NAMESPACE = 'attribute'
  hstore :data, :accessors => {
      "run_length" => :integer,
      "ink_coverage" => :integer,
      "clicks" => :integer,
      "book_size" => :integer,
      "pages" => :integer,
      "sale_price" => :integer,
      "annual_growth" => :integer,
      "job_percentage" => :integer
  }

  validates_numericality_of :pages

end


#Job fields consist of:
#                       - Name
#- Run Length / Copies
#- Clicks / Impressions
#- Book Size
#- No. of Pages
#- Sale Price
#- Annual Growth
#- Job Percentage
#- User ID (FK)