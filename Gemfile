source 'https://rubygems.org'
ruby '2.0.0'

gem "rails", "3.2.13"
gem "thin", "~> 1.5.1"                            # Thin webserver, recommended by heroku
gem "pg", "~> 0.15.1"                             # Postgres gem
gem "heroku", "~> 2.37.2"                         # Heroku hosting
gem "jquery-rails", "~> 2.2.1"                    # Include jquery assets in pipeline
gem "devise", "~> 2.2.3"                          # User authentication for users
gem "activerecord-postgres-hstore", "~> 0.7.6"    # Dynamically create fields off your models
gem "activeadmin", "~> 0.6.0"                     # The administration framework for Ruby on Rails
gem "meta_search",    '>= 1.1.0.pre'

group :assets do
  gem "uglifier", "~> 2.0.1"
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'zurb-foundation', '~> 4.1.2'

end

group :development, :test do
  gem "awesome_print"                             # Nicely formatted data structures in console, for example "ap User.first"
end

group :test do
  gem "rspec-rails", "~> 2.13.0"
  gem "capybara", "~> 2.1.0"
  gem "database_cleaner", "~> 0.9.1"
  gem "xpath", "~> 2.0.0"
  gem "selenium-webdriver", "~> 2.32.1"
  gem "capybara-firebug", '~> 1.3.0'
end
