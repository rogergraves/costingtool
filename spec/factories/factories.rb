FactoryGirl.define do
#
#  factory :user do
#    sequence(:email) {|n| "email#{n}@factory.com" }
#    password 'pleaseplease'
#    password_confirmation 'pleaseplease'
#  end
#

  factory :press_type do
    name "My Press #{1000*Random.rand(10)}"
  end
  
  factory :job do
    sequence(:name) {|n| "Job #{n}" }
    pages_per_month (1000+Random.rand(1000000))
    number_of_jobs (1000+Random.rand(100000))
    copies_per_job (100+Random.rand(10000))
    multicolor_clicks Random.rand(6)
    black Random.rand(1)
    number_of_pages Random.rand(10000)
    plex 1+Random.rand(1)
    sale_price ((100+Random.rand(500))/100)
    annual_growth Random.rand(100)
    job_percentage 25
    job_size 'A5'
  end

  factory :press_job do
    job
    press_type
    press_cost 3.00
    media_cost 2.99
    labor_cost 300.00
    spi_cost 1000.00
    clicks_cost 100.00
  end

  factory :click_table do
    sequence(:description) { |n| "Table #{n}" }
  end

  factory :ink_array do
    click_table
    sequence(:description) { |n| "Ink setup #{n}" }
    color_range_start 3
    color_range_end 3
    black 1
  end

  factory :tier do
    ink_array
    sequence(:label) { |n| "Tier #{n}" }
    volume_range_start 0
    volume_range_end 1000000
    price 1.50
  end

  factory :media do
    sequence(:name) { |n| Job.available_sizes[n-1]}
    cost_per_sheet 1.25
  end
end
