source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.11'

# Use postgres as the default database for Active Record
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
 
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Twitter Bootstrap for CSS framework
gem 'bootstrap-sass', '~> 3.1.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use Devise authentication
gem 'devise'

# For creating fake data in dbs
gem 'faker'

# For secure storage of authentication credentials
gem 'figaro', '1.0'

# Authorization class framework
gem 'pundit'

# Markdown support
gem 'redcarpet'

# Image upload and manipulation support
gem 'carrierwave'
gem 'mini_magick'

# S3 support
gem 'fog'

# Pagination support
gem 'will_paginate', '~> 3.0.5'

# debugging support
group :development, :test do
  gem 'sqlite3'
  gem 'pry-rails'
  gem 'pry-byebug'
end

# Test framework
group :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
end

# For improved error reporting
group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

# For performance monitoring
gem 'newrelic_rpm'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
