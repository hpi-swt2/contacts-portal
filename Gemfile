source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}.git" }

# ruby version
ruby '2.7.2'

#
# Rails essentials
#

# The application framework
gem 'rails', '~> 6.0', '>= 6.0.3.4' # https://github.com/rails/rails
# Sqlite3 as the database for ActiveRecord.
gem 'sqlite3', '~> 1.4', '>= 1.4.2' # https://www.sqlite.org/index.html
# Development server
gem 'puma', '~> 5.0', '>= 5.0.2' # https://github.com/puma/puma
# Compressor for JavaScript assets
gem 'uglifier', '~> 4.2' # https://github.com/lautis/uglifier
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', '~> 0.3.1'
# Turbolinks makes navigating your web application faster
# When you follow a link, Turbolinks automatically fetches the page, swaps in its <body>, and merges its <head>
gem 'turbolinks', '~> 5.2', '>= 5.2.1' # https://github.com/turbolinks/turbolinks
# Optimize and cache expensive computations; required in config/boot.rb
gem 'bootsnap', require: false # https://github.com/Shopify/bootsnap

#
# Additional core gems
#

# Use devise as an authentication solution for Rails with Warden
gem 'devise', '~> 4.7', '>= 4.7.3' # https://github.com/plataformatec/devise
gem 'devise-i18n', '~> 1.9', '>= 1.9.2' # https://github.com/tigrish/devise-i18n
gem 'devise-bootstrap-views', '~> 1.1' # https://github.com/hisea/devise-bootstrap-views

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2020', '>= 1.2020.2', platforms: [:mingw, :mswin, :x64_mingw, :jruby] # https://github.com/tzinfo/tzinfo-data

#
# Packaged JS, CSS libraries and helpers
#

# HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web
gem 'bootstrap', '~> 4.5', '>= 4.5.2' # https://github.com/twbs/bootstrap-rubygem
# Provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5' # https://github.com/bokmann/font-awesome-rails
# jQuery JavaScript framework packaged for Rails
gem 'jquery-rails', '~> 4.4' # https://github.com/rails/jquery-rails

#
# Gems that depend on the build kind (development/test/production)
#

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.1', '>= 11.1.3', platforms: [:mri, :mingw, :x64_mingw] # https://github.com/deivid-rodriguez/byebug
  # RSpec testing framework as a drop-in alternative to Rails' default testing framework, Minitest
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1' # https://github.com/rspec/rspec-rails
  # State of the art fixtures
  gem 'factory_bot_rails', '~> 6.1' # https://github.com/thoughtbot/factory_bot_rails
  # Ruby static code analyzer (a.k.a. linter) and code formatter
  gem 'rubocop', '~> 0.93.1', require: false # https://github.com/rubocop-hq/rubocop
  # Rails Extension for Rubocop
  gem 'rubocop-rails', '~> 2.8', '>= 2.8.1', require: false # https://github.com/rubocop-hq/rubocop-rails
  # rspec Extension for Rubocop
  gem 'rubocop-rspec', '~> 1.43', '>= 1.43.2', require: false # https://github.com/rubocop-hq/rubocop-rspec
  # Performance optimization analysis for your projects
  gem 'rubocop-performance', '~> 1.8', '>= 1.8.1', require: false # https://github.com/rubocop-hq/rubocop-performance
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code
  gem 'web-console', '~> 4.0', '>= 4.0.4' # https://github.com/rails/web-console
  # The Listen gem listens to file modifications and notifies you about the changes
  gem 'listen', '~> 3.2', '>= 3.2.1' # https://github.com/guard/listen
  # Spring speeds up development by keeping your application running in the background
  gem 'spring', '~> 2.1', '>= 2.1.1' # https://github.com/rails/spring
  # Makes Spring watch the filesystem for changes using Listen rather than by polling the filesystem
  gem 'spring-watcher-listen', '~> 2.0', '>= 2.0.1' # https://github.com/jonleighton/spring-watcher-listen
  # Replaces standard Rails error page with a more useful error page
  gem 'better_errors', '~> 2.8', '>= 2.8.3'
  # binding_of_caller is optional, but is necessary to use Better Errors' advanced features
  gem 'binding_of_caller', '~> 0.8.0'
end

group :test do
  # Capybara: Test web applications by simulating how a real user would interact with your app
  gem 'capybara', '~> 3.33' # https://github.com/teamcapybara/capybara/blob/3.33_stable/README.md#using-capybara-with-rspec
  # Run Selenium tests more easily with install and updates for all supported webdrivers
  gem 'webdrivers', '~> 4.0', require: false # https://github.com/titusfortner/webdrivers
  # Generates fake data (especially useful for tests)
  gem 'faker', '~> 2.14' # https://github.com/faker-ruby/faker
  # Provides one-liners to test common rails functionality, that, if written by hand, would be much longer
  gem 'shoulda-matchers', '~> 4.0' # https://github.com/thoughtbot/shoulda-matchers
end

group :production do
  # production database runs on postgres
  gem 'pg', '~> 1.2', '>= 1.2.3'
end