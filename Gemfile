source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

gem 'delayed_job_active_record'

# exception tracking
gem 'exceptional'

# file uploading
gem 'carrierwave'
gem 'mini_magick'

# authentication
gem 'authlogic'

# frontend related gems
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'compass-rails'
gem 'zurb-foundation'
gem 'jquery-rails'
gem 'turbolinks'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'capistrano', '= 2.15.5', group: :development

group :production do
  gem 'pg'
  gem 'unicorn'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'quiet_assets'
  gem 'awesome_print'
end