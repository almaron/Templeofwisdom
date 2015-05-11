require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #show' do

    before do
      create :season
      get :show
    end

    it 'should return ok' do
      expect(response.status).to eql 200
    end

    it 'should assign a season' do
      expect(assigns :season).to be_a Season
    end
  end
end
