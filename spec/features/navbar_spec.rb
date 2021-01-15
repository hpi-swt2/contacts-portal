require 'rails_helper'

RSpec.describe 'Navbar', driver: :selenium_headless, type: :feature, js: true do
  let(:user) { FactoryBot.create :user }

  before do
    sign_in user
    visit root_path
  end

  describe 'profile dropdown' do
    it 'is not expanded by default' do
      profile_dropdown = page.find('#navbarProfileDropdown + div', visible: :all)
      expect(profile_dropdown['class']).not_to include('show')
    end

    it 'expands after being clicked on' do
      toggle_profile_dropdown
      profile_dropdown = page.find('#navbarProfileDropdown + div')
      expect(profile_dropdown['class']).to include('show')
    end

    it 'contains a link to the users profile page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: user_path(user))
      end
    end

    it 'contains a link to the account settings page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: edit_user_registration_path(user))
      end
    end

    it 'contains a link to the users edit profile page' do
      toggle_profile_dropdown
      within '#navbarProfileDropdown + div' do
        expect(page).to have_link(href: edit_user_path(user))
      end
    end

    def toggle_profile_dropdown
      page.execute_script('document.getElementById("navbarProfileDropdown").click()')
    end
  end

  describe 'anonymous page' do
    before do
      sign_out
    end

    it 'does not contain a link to the notes page' do
      expect(page).not_to have_link(href: notes_path())
    end

    it 'does not contain a link to the users page' do
      expect(page).not_to have_link(href: users_path())
    end
  end
end
