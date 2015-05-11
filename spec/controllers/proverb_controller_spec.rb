require 'rails_helper'

RSpec.describe ProverbController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it 'should return a proverb' do
      get :show
      expect(assigns :proverb).to be_present
    end
  end

end
