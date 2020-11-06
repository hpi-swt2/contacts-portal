require 'rails_helper'

require 'capybara/dsl'

RSpec.configure do |config|
  config.include Capybara::DSL
end

RSpec.describe "Users", type: :request do
  it "can sign up" do 
    visit root_path
    
    click_on "Sign-Up"

    fill_in "Email", :with => "test@test.de"
    fill_in "Password", :with => "123456"
    fill_in "Password confirmation", :with => "123456"

    click_on 'Sign up'

    expect(page).to have_current_path root_path
    expect(page).to have_content "Welcome! You have signed up successfully."
  end
end