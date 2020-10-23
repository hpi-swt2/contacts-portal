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
# use sed to add the line "has_many :notes, dependent: :delete_all" to the user class definition.
# for a reference on how this statement is cunstructed, see: https://stackoverflow.com/questions/6739258/how-do-i-add-a-line-of-text-to-the-middle-of-a-file-using-bash
sed -i 'H;${x;s/^\n//;s/end$/  has_many :notes, dependent: :delete_all\n&/;p;}' app/models/user.rb

# migrate database
bundle exec rails db:migrate