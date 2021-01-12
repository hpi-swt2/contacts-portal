require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    @users = assign(:users, FactoryBot.create_list(:user, 3))
    sign_in @users.first
  end

  it "renders a list of users" do
    render
    @users.each do |user|
      expect(rendered).to match user.email
    end
  end

  it "has an + button to send contact request" do
    render
    expect(rendered).to have_button('+', count: @users.length)
  end

  it "does not have a + button for already requested user" do
    @users.second.contact_requests << @users.first
    render
    expect(rendered).not_to have_css('form.button_to[action="/users/2/contact_requests"]')
  end

  it "does not have a + button for already existing contacts" do
    @users.first.contacts << @users.second
    render
    expect(rendered).not_to have_css('form.button_to[action="/users/2/contact_requests"]')
  end
end
