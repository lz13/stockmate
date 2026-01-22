require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    it "returns http success for root path" do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "renders the home page with correct content" do
      get "/"
      expect(response.body).to include("StockMate")
    end
  end

  describe "GET /dashboard" do
    context "when user is signed in" do
      let(:user) { create(:user) }

      before { sign_in user }

      it "returns https success" do
        get "/dashboard"
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign-in page" do
        get "/dashboard"
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
