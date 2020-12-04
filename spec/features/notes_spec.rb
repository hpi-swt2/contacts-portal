require 'rails_helper'

describe "Notes", type: :feature do
  before(:each) do
    @alice = User.new(id: 1, email: "alice@example.com", password: "1234567")
    assert @alice.save
    @bob = User.new(id: 2, email: "bob@example.com", password: "9876543")
    assert @bob.save
    login(@alice)
  end

  # TODO: Split up
  it "can create a new note" do
    visit notes_path
    click_link "New Note"
    fill_in "Title", with: "My Title"
    fill_in "Content", with: "My Content"
    fill_in "User", with: @bob.id
    click_button "Create Note"

    visit notes_path
    expect(page).to have_text("My Title")
    expect(page).to have_text("My Content")
    expect(page).to have_text(@bob.id)

    logout
    login(@bob)
    visit notes_path
    expect(page).not_to have_text("My Title")
  end

  def login(user)
    visit root_path
    click_link "Log-In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  def logout
    visit root_path
    click_link "Log Out"
  end
end
