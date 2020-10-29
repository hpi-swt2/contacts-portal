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
sed -ni 'H;${x;s/^\n//;s/end$/  config.action_mailer.default_url_options = { host: \x27localhost\x27, port: 3000 }\n&/;p;}' config/environments/development.rb

# add 'root to: "devise/sessions#new"' to config/routes.rb
sed -ni 'H;${x;s/^\n//;s/end$/  root to: \x27devise\/sessions#new\x27\n&/;p;}' config/routes.rb

# add link to devise docs to routes configuration
sed -ni 'H;${x;s/^\n//;s/devise_for :users/# https:\/\/github\.com\/heartcombo\/devise\/wiki\/\n  &/;p;}' config/routes.rb

# preparate  the application layout file's body to contain the follwing:
# <div class="container-fluid">
#   <p class="notice"><%= notice %></p>
#   <p class="alert"><%= alert %></p>
# </div>
# <div class="container-fluid">
#   <%= yield %>
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

# remove notes helper spec. We don't have any note helpers so we don't need to test them
rm spec/helpers/notes_helper_spec.rb

# remove notice from app/view/notes/index.html.erb and app/view/notes/show.html.erb, as it is already stated in app/views/layouts/application.html.erb
sed -ni 'H;${x;s/^\n//;s/^<p id=\"notice\"><%= notice %><\/p>\n\n//;p;}' app/views/notes/index.html.erb
sed -ni 'H;${x;s/^\n//;s/^<p id=\"notice\"><%= notice %><\/p>\n\n//;p;}' app/views/notes/show.html.erb

#
# styling
#

# replace app/assets/stylesheets/application.css with a scss file, to import bootstrap
mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss

# remove css specifics that do not apply to scss
sed -ni 'H;${x;s/^\n//;s/\n \*\n \*= require_tree \.\n \*= require_self/\n/;p;}' app/assets/stylesheets/application.scss

# add bootstrap variables and import bootstrap
applicationStylesheet="

// Remove all the *= require and *= require_tree statements from the Sass file.
// Instead, use @import to import Sass files.
// Do not use *= require in Sass or your other stylesheets will not be 
// able to access the Bootstrap mixins and variables.
// See: https://github.com/twbs/bootstrap-rubygem#a-ruby-on-rails
// Custom bootstrap variables must be set or *before* bootstrap is imported
// https://github.com/twbs/bootstrap-rubygem/blob/master/assets/stylesheets/bootstrap/_variables.scss
\$primary: #dd6108;
\$primary-active: #ef8d47;
\$primary-hover: #cc5908;
\$danger: #c60505;
\$success: #00911f;
// $secondary: #dd6108;
// $success: #dd6108;
// $info: #dd6108;
// \$warning: #dd6108;
// \$danger: #dd6108;
// \$light: #dd6108;
// \$dark: #dd6108;
// https://github.com/twbs/bootstrap-rubygem
@import 'bootstrap';
// https://github.com/bokmann/font-awesome-rails
@import 'font-awesome';"

printf '%s' "${applicationStylesheet}" >> app/assets/stylesheets/application.scss

#
# configuring i18n
#

# remove hello world string from english dictionary
sed -ni 'H;${x;s/^\n//;s/\n  hello: \"Hello world\"//;p;}' config/locales/en.yml

# add english strings
englishDictionary="
  questions:
    confirmation: 'Are you sure?'
  confirmation:
    resource_creation: '%{resource} was successfully created.'
    resource_deletion: '%{resource} was successfully deleted.'
    resource_update: '%{resource} was successfully updated.'"

printf '%s' "${englishDictionary}" >> config/locales/en.yml

# replace 'Are you sure?' with I18n.t('questions.confirmation')
sed -ni 'H;${x;s/^\n//;s/\x27Are you sure?\x27/I18n\.t(\x27questions\.confirmation\x27)/;p;}' app/views/notes/index.html.erb

# replace 'Note was successfully created.' with I18n.t('confirmation.resource_creation', resource: Note)
sed -ni 'H;${x;s/^\n//;s/\x27Note was successfully created.\x27/I18n.t(\x27confirmation\.resource_creation\x27, resource: Note)/;p;}' app/controllers/notes_controller.rb

# replace 'Note was successfully updated.' with I18n.t('confirmation.resource_update', resource: Note)
sed -ni 'H;${x;s/^\n//;s/\x27Note was successfully updated.\x27/I18n.t(\x27confirmation\.resource_update\x27, resource: Note)/;p;}' app/controllers/notes_controller.rb

# replace 'Note was successfully destroyed.' with I18n.t('confirmation.resource_deletion', resource: Note)
sed -ni 'H;${x;s/^\n//;s/\x27Note was successfully destroyed.\x27/I18n.t(\x27confirmation\.resource_deletion\x27, resource: Note)/;p;}' app/controllers/notes_controller.rb

# replace pluralize(note.errors.count, "error") %> prohibited this note from being saved: with I18n.t 'errors.messages.not_saved.other', count: note.errors.count, resource: Note%>
sed -ni 'H;${x;s/^\n//;s/pluralize(note\.errors\.count, "error") %> prohibited this note from being saved:/I18n\.t \x27errors\.messages\.not_saved\.other\x27, count: note\.errors\.count, resource: Note%>/;p;}' app/views/notes/_form.html.erb

#
# use factory bot
#

# add user factory
userFactory="FactoryBot.define do
  factory :user do
    email { random_name + '@rolodex-portal.de' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

def random_name
  ('a'..'z').to_a.shuffle.join
end"

printf '%s' "${userFactory}" > spec/factories/users.rb

# add user creation to note factory
sed -ni 'H;${x;s/^\n//;s/nil/FactoryBot\.create(:user)/;p;}' spec/factories/notes.rb

# use FactoryBot in note view tests
sed -ni 'H;${x;s/^\n//;s/assign(:note, Note\.create!(\n      title: \"MyString\",\n      content: \"MyText\",\n      user: nil\n    ))/FactoryBot\.create(:note)/;p;}' spec/views/notes/edit.html.erb_spec.rb
sed -ni 'H;${x;s/^\n//;s/Note\.create!(\n        title: \"Title\",\n        content: \"MyText\",\n        user: nil\n      )/FactoryBot\.create(:note)/;p;}' spec/views/notes/index.html.erb_spec.rb
sed -ni 'H;${x;s/^\n//;s/Note\.create!(\n        title: \"Title\",\n        content: \"MyText\",\n        user: nil\n      )/FactoryBot\.create(:note)/;p;}' spec/views/notes/index.html.erb_spec.rb
sed -ni 'H;${x;s/^\n//;s/assign(:note, Note\.create!(\n      title: \"Title\",\n      content: \"MyText\",\n      user: nil\n    ))/FactoryBot\.create(:note)/;p;}' spec/views/notes/show.html.erb_spec.rb