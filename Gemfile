source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :production do
  gem 'mysql2'
end

gem 'sqlite3'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use thin as the web server
gem 'thin'

# Deploy with Capistrano
gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

gem 'rest-client'

gem 'delayed_job_active_record'

# Performance Testing
group :development do
  gem 'ruby-prof'
end

# Testing
group :development, :test do
  # Anything above 1.4.0 seems to be broken using RubyGems 1.3.7, the current
  # default in Ubuntu 11.04.
  gem 'factory_girl_rails', '1.4.0', :require => false
  gem 'mocha'
  gem 'rspec-rails'
  gem 'shoulda-matchers', :git => 'git://github.com/thoughtbot/shoulda-matchers.git'
  gem 'simplecov'
end

# Authentication
gem 'devise'

# Authorisation
gem 'declarative_authorization'
group :development do
  gem 'ruby_parser' # for info on authorisation rules
end
