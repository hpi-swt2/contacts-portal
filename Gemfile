source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}.git" }

# ruby version
ruby '2.7.1'

#
# Rails essentials
#

# The application framework. https://github.com/rails/rails
gem 'rails', '~> 6.0', '>= 6.0.3.4'
# Use sqlite3 as the database for Active Record. https://www.sqlite.org/index.html
gem 'sqlite3', '~> 1.4', '>= 1.4.2'
# Use Puma as the app server. https://github.com/puma/puma
gem 'puma', '~> 5.0', '>= 5.0.2'
# Use Uglifier as compressor for JavaScript assets. https://github.com/lautis/uglifier
gem 'uglifier', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'mini_racer', '~> 0.3.1'
# Turbolinks makes navigating your web application faster. https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.4', '>= 1.4.8'

#
# Additional core gems
#

# Use devise as an authentication solution for Rails with Warden
gem 'devise', '~> 4.7', '>= 4.7.3' # https://github.com/plataformatec/devise
gem 'devise-i18n', '~> 1.9', '>= 1.9.2' # https://github.com/tigrish/devise-i18n
gem 'devise-bootstrap-views', '~> 1.1' # https://github.com/hisea/devise-bootstrap-views

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2020', '>= 1.2020.2', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

#
# Packaged JS, CSS libraries and helpers
#

# The most popular HTML, CSS, and JavaScript framework for developing responsive, mobile first projects on the web.
gem 'bootstrap', '~> 4.5', '>= 4.5.2' # https://github.com/twbs/bootstrap-rubygem
# font-awesome-rails provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5' # https://github.com/bokmann/font-awesome-rails
# jQuery for Rails
gem 'jquery-rails', '~> 4.4' # https://github.com/rails/jquery-rails

#
# Gems that depend on the build kind (development/test/production)
#

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console. https://github.com/deivid-rodriguez/byebug
  gem 'byebug', '~> 11.1', '>= 11.1.3', platforms: [:mri, :mingw, :x64_mingw]
  # RSpec testing framework as a drop-in alternative to Rails' default testing framework, Minitest
  gem 'rspec-rails', '~> 4.0', '>= 4.0.1' # https://github.com/rspec/rspec-rails
  # State of the art fixtures
  gem 'factory_bot_rails', '~> 6.1' # https://github.com/thoughtbot/factory_bot_rails
  # Linter / Formatter using Rubocop https://github.com/rubocop-hq/rubocop
  gem 'rubocop', '~> 0.93.1', require: false
  # Rails Extension for Rubocop https://github.com/rubocop-hq/rubocop-rails
  gem 'rubocop-rails', '~> 2.8', '>= 2.8.1', require: false
  # rspec Extension for Rubocop https://github.com/rubocop-hq/rubocop-rspec
  gem 'rubocop-rspec', '~> 1.43', '>= 1.43.2', require: false
  # Extension for Rubocop https://github.com/rubocop-hq/rubocop-performance
  gem 'rubocop-performance', '~> 1.8', '>= 1.8.1', require: false
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '~> 4.0', '>= 4.0.4' # https://github.com/rails/web-console
  # The Listen gem listens to file modifications and notifies you about the changes.
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
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 3.33'
  # Run Selenium tests more easily with install and updates for all supported webdrivers.
  gem 'webdrivers', '~> 4.4', '>= 4.4.1'
  # Port of Perl's Data::Faker library that generates fake data
  gem 'faker', '~> 2.14'
  # Provides one-liners to test common rails functionality, that, if written by hand, would be much longer
  gem 'shoulda-matchers', '~> 4.4', '>= 4.4.1'
end

group :production do
  # production database runs on postgres
  gem 'pg', '~> 1.2', '>= 1.2.3'
end