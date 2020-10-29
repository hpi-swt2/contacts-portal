FactoryBot.define do
  factory :user do
    email { random_name + '@rolodex-portal.de' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

def random_name
  ('a'..'z').to_a.shuffle.join
end