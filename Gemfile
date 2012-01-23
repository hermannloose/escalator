source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

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

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

gem 'rest-client'

gem 'delayed_job_active_record'

# Mocking
group :development, :test do
  gem 'mocha'
end

# Performance Testing
group :development do
  gem 'ruby-prof'
end

group :development, :test do
  gem 'mocha'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

# Authentication
gem 'devise'

# Authorisation
gem 'declarative_authorization'
group :development do
  gem 'ruby_parser' # for info on authorisation rules
end
