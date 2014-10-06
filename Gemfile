source 'https://rubygems.org'

gem 'rails', '4.0.0'
gem 'ruby-ntlm'
# CORS
gem 'rack-cors', require: 'rack/cors'

# JSON responses
gem 'rabl'

# Static Pages
gem 'high_voltage'

# Tracking exceptions
gem 'exceptional'
gem 'acts_as_votable', '~> 0.8.0'

# Intercom
gem 'intercom'
gem 'intercom-rails'

# Delayed jobs
gem 'daemons'
gem 'delayed_job_active_record'
gem 'delayed_job_web'

# Pagination
gem 'kaminari'

# Payment
gem 'stripe'

# file uploading
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'

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

gem 'capistrano', '= 2.15.5', group: :development

group :production, :staging do
  gem 'pg'
  gem 'unicorn'
end

group :staging do
  gem 'rails_12factor', '~> 0.0.2'
end

group :development, :test do

  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'quiet_assets'
  gem 'awesome_print'
end