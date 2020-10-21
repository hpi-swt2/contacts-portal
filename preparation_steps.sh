# create a folder to install gems locally
mkdir vendor
mkdir vendor/bundle
bundle config set path vendor/bundle
bundle install

# generate basic rails application
yes n | bundle exec rails new . --skip-spring --skip-listen 

# create devise user
bundle exec rails generate devise:install
bundle exec rails generate devise user
bundle exec rails generate devise:views user

# generate note
bundle exec rails generate scaffold note title:string content:text user:references
# manually add to user class: has_many :note

# migrate database
bundle exec rails db:migrate