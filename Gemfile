source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Allows generate JSON in an object-oriented and convention-driven manner
gem 'active_model_serializers', '~> 0.10.13'
# Middleware that will make Rack-based apps CORS compatible
gem 'rack-cors', '~> 1.1', '>= 1.1.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
gem 'pundit', '~> 2.1', '>= 2.1.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'omniauth'
gem 'devise'
gem 'devise_token_auth'
gem 'search_flip'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'
  gem 'faker', '~> 2.19'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'dotenv-rails'
  gem 'database_cleaner'
  gem 'pry'
  # Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema
  gem 'annotate', '~> 3.1', '>= 3.1.1'
end

group :development do
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Ruby code style checking and code formatting tool
  gem 'rubocop', '~> 0.93.1', require: false
  # Includes Rubocop configuration used at Airbnb and a few custom rules
  gem 'rubocop-airbnb', '~> 4.0', require: false
  # A collection of RuboCop cops to check for performance optimizations
  gem 'rubocop-performance', '~> 1.10.2', require: false
  # Automatic Rails code style checking tool
  gem 'rubocop-rails', '~> 2.9.1'
  # Code style checking for RSpec files
  gem 'rubocop-rspec', '~> 1.44.1', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
