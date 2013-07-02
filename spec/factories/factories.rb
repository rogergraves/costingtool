FactoryGirl.define do

  factory :user do
    email {|n| "fake_user_#{n}@hp.com" }
    company Faker::Company.name
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    country User.available_countries.sample
    password 'pleaseplease'
    password_confirmation 'pleaseplease'
    after(:create) do |user|
      user.skip_confirmation!
    end
  end

  factory :press_type do
    name "#{Faker::Company.catch_phrase.split(' ').map(&:capitalize).join(' ')} Press"
    click_table
    duty_cycle 1000000000
    spi 2000.0
    price 900000.0
    production_life_months 84
  end

  factory :imposition do
    press_type
    sequence(:job_size) do |n|
      Job.available_sizes[(n-1)%Job.available_sizes.length]
    end
    sequence(:ups) {|n| (7-n).to_s}
  end
  
  factory :job do
    user
    sequence(:name) {|n| "Job #{n}" }
    number_of_jobs (2000+Random.rand(1000))
    copies_per_job (500+Random.rand(100))
    job_size Job.available_sizes.sample
    multicolor_clicks Random.rand(6)
    black Random.rand(1)
    number_of_pages Random.rand(20)
    plex 1+Random.rand(1)
    sale_price ((100+Random.rand(500))/100)
    annual_growth Random.rand(30)
    job_percentage 25
  end

  factory :press_job do
    job
    press_type
    press_price 1000000
    media_cost 2.99
    labor_cost 300.00
    spi_cost 1000.00
    clicks_cost 100.00
  end

  factory :click_table do
    sequence(:description) { |n| "Table #{n}" }
    name Faker::Company.catch_phrase
    factory :click_table_with_tier do
      after(:create) do |instance|
        create(:ink_array_with_tier, click_table: instance)
      end
    end
  end

  factory :ink_array do
    click_table
    sequence(:name) { |n| "Ink setup #{n}" }
    color_range_start 0
    color_range_end 6
    black 1
    factory :ink_array_with_tier do
      after(:create) do |instance|
        create(:tier, ink_array: instance, volume_range_end: nil)
      end
    end
  end

  factory :tier do
    ink_array
    sequence(:name) { |n| "Tier #{n}" }
    volume_range_start 0
    volume_range_end 1000000
    price 1.50
    black_price 1.00
  end

  factory :media do
    name Job.available_sizes.sample
    cost_per_sheet 1.25
  end
end
