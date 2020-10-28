#!/bin/bash

# Many manual adaptations have been automated with sed to use this script in case we need to re-build the whole skeleton.
# for a reference on sed statements can be cunstructed, see: https://stackoverflow.com/questions/6739258/how-do-i-add-a-line-of-text-to-the-middle-of-a-file-using-bash

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
sed -ni 'H;${x;s/^\n//;s/end$/  config.action_mailer.default_url_options = { host: \"localhost\", port: 3000 }\n&/;p;}' config/environments/development.rb

# add 'root to: "devise/sessions#new"' to config/routes.rb
sed -ni 'H;${x;s/^\n//;s/end$/  root to: \"devise\/sessions#new\"\n&/;p;}' config/routes.rb

# add link to devise docs to routes configuration
sed -ni 'H;${x;s/^\n//;s/devise_for :users/# https:\/\/github\.com\/heartcombo\/devise\/wiki\/\n  &/;p;}' config/routes.rb

# preparate  the application layout file's body to contain the follwing:
# <div class="container-fluid">
#   <%= yield %>
# </div>
# <div class="container-fluid">
#   <p class="notice"><%= notice %></p>
#   <p class="alert"><%= alert %></p>
# </div>
sed -ni 'H;${x;s/^\n//;s/    <%= yield %>/    <div class=\"container-fluid\">\n      <p class=\"notice\"><%= notice %><\/p>\n      <p class=\"alert\"><%= alert %><\/p>\n    <\/div>\n    <div class=\"container-fluid\">\n      <%= yield %>\n    <\/div>/;p;}' app/views/layouts/application.html.erb

# generate the user
bundle exec rails generate devise user

# generate user views
bundle exec rails generate devise:views user

#
# generate note
#

# generate note scaffold
bundle exec rails generate scaffold note title:string content:text user:references

# add "has_many :notes, dependent: :delete_all" to the user class definition.
sed -ni 'H;${x;s/^\n//;s/end$/  # The dependent: option allows to specify that associated records should be deleted when the owner is deleted\n  # https:\/\/api\.rubyonrails\.org\/classes\/ActiveRecord\/Associations\/ClassMethods.html >> Deleting from Associations\n  has_many :notes, dependent: :delete_all\n&/;p;}' app/models/user.rb

# add link to devise documentation
sed -ni 'H;${x;s/^\n//;s/devise :database_authenticatable, :registerable,/# https:\/\/github\.com\/heartcombo\/devise\/wiki\/\n  &/;p;}' app/models/user.rb

#
# migrate database
#

bundle exec rails db:migrate

#
# cleanup
#

# remove Rakefile
rm Rakefile

#
# styling
#

# replace app/assets/stylesheets/application.css with a scss file
mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss
sed -ni 'H;${x;s/^\n//;s/\n \*\n \*= require_tree \.\n \*= require_self/\n/;p;}' app/assets/stylesheets/application.scss

SCSSLines=(
    ""
    "// Remove all the \*= require and \*= require_tree statements from the Sass file."
    "// Instead, use @import to import Sass files."
    "// Do not use \*= require in Sass or your other stylesheets will not be "
    "// able to access the Bootstrap mixins and variables."
    "// See: https://github.com/twbs/bootstrap-rubygem#a-ruby-on-rails"
    ""
    "// Custom bootstrap variables must be set or *before* bootstrap is imported"
    "// https://github.com/twbs/bootstrap-rubygem/blob/master/assets/stylesheets/bootstrap/_variables.scss"
    "\$primary: #dd6108;"
    "\$primary-active: #ef8d47;"
    "\$primary-hover: #cc5908;"
    "\$danger: #c60505;"
    "\$success: #00911f;"
    "// \$secondary: #dd6108;"
    "// \$success: #dd6108;"
    "// \$info: #dd6108;"
    "// \$warning: #dd6108;"
    "// \$danger: #dd6108;"
    "// \$light: #dd6108;"
    "// \$dark: #dd6108;"
    "// https://github.com/twbs/bootstrap-rubygem"
    "@import \"bootstrap\";"
    "// https://github.com/bokmann/font-awesome-rails"
    "@import \"font-awesome\";"
)

for line in "${SCSSLines[@]}"; do
    echo ${line} >> app/assets/stylesheets/application.scss
done