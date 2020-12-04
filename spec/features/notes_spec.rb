require 'rails_helper'

describe "Notes", type: :feature do
  before(:each) do
    @alice = User.new(id: 1, email: "alice@example.com", password: "123")
    @bob = User.new(id: 2, email: "bob@example.com", password: "456")
    login(@alice)
  end

  # TODO: Split up
  it "can create a new note" do
    visit note_path
    find("a", text: "New Note").click
    fill_in "Title", with: "My Title"
    fill_in "Content", with: "My Content"
    fill_in "User", with: @bob.id
    click "Create Note"

    visit note_path
    expect(page).to have_text("My Title")
    expect(page).to have_text("My Content")
    expect(page).to have_text(@bob.id)

    logout
    login(@bob)
    visit note_path
    expect(page).not_to have_text("My Title")
  end

  def login(user)
    visit root_path
    click "Log-In"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click "Log in"
  end

  def logout
    visit root_path
    click "Sign Out"
  end
end
