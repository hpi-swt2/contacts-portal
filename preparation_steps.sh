#!/bin/bash

#
# create a folder to install gems locally
#

mkdir vendor
mkdir vendor/bundle
bundle config set path vendor/bundle
bundle install

#
# generate basic rails application
#

yes n | bundle exec rails new . --skip-spring --skip-listen 

#
# create devise user
#

bundle exec rails generate devise:install

# add 'config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }' to 'config/environments/development.rb'
# for a reference on how this statement is cunstructed, see: https://stackoverflow.com/questions/6739258/how-do-i-add-a-line-of-text-to-the-middle-of-a-file-using-bash
sed -ni 'H;${x;s/^\n//;s/end$/  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }\n&/;p;}' config/environments/development.rb
# add 'root to: "devise/sessions#new"' to config/routes.rb
sed -ni 'H;${x;s/^\n//;s/end$/  root to: \"devise\/sessions#new\"\n&/;p;}' config/routes.rb
# preparate  the application layout file's body to contain the follwing:
# <div class="container-fluid">
#   <%= yield %>
# </div>
# <div class="container-fluid">
#   <p class="notice"><%= notice %></p>
#   <p class="alert"><%= alert %></p>
# </div>
sed -ni 'H;${x;s/^\n//;s/    <%= yield %>/    <div class=\"container-fluid\">\n&/;p;}' app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/    <%= yield %>/      <%= yield %>/;p;}' app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/  <\/body>/    <\/div>\n&/;p;}' app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/  <\/body>/    <div class=\"container-fluid\">\n&/;p;}' app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/  <\/body>/      <p class=\"notice\"><%= notice %><\/p>\n&/;p;}' app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/  <\/body>/      <p class=\"alert\"><%= alert %><\/p>\n&/;p;}' app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/  <\/body>/    <\/div>\n&/;p;}' app/views/layouts/application.html.erb
# generate the user
bundle exec rails generate devise user
# generate user views
bundle exec rails generate devise:views user

#
# generate note
#

bundle exec rails generate scaffold note title:string content:text user:references
# add "has_many :notes, dependent: :delete_all" to the user class definition.
sed -ni 'H;${x;s/^\n//;s/end$/  has_many :notes, dependent: :delete_all\n&/;p;}' app/models/user.rb

#
# migrate database
#
bundle exec rails db:migrate