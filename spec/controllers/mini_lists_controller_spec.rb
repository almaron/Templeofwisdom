require 'rails_helper'

RSpec.describe MiniListsController, type: :controller do

  describe "GET #news" do
    it "returns http success" do
      get :news
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #blog" do
    it "returns http success" do
      get :blog
      expect(response).to have_http_status(:success)
    end
  end

end
