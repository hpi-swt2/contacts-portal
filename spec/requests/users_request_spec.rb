require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create :user }
  let(:user2) { FactoryBot.create :user }

  describe "GET /show" do
    it "returns http success" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /status" do
    it 'redirects to root when not logged in' do
      patch update_status_user_path(user)
      expect(response).to redirect_to(root_path)
    end

    it 'does not redirect when user is signed in' do
      sign_in user
      patch update_status_user_path(user)
      expect(response).to render_template :show
    end

    it 'redirects to root when editing another user' do
      sign_in user2
      patch update_status_user_path(user)
      expect(response).to redirect_to(root_path)
    end
  end
end