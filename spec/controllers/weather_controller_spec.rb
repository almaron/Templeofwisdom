require 'rails_helper'

RSpec.describe WeatherController, type: :controller do
  describe 'GET #show' do
    it 'should return ok' do
      get :show
      expect(response.status).to eql 200
    end
  end
end
