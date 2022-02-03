require 'rails_helper'

RSpec.describe "Profiles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/profiles/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/profiles/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/profiles/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/profiles/create"
      expect(response).to have_http_status(:success)
    end
  end

end
