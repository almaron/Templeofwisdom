require 'rails_helper'

RSpec.describe JournalTagsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do

    context 'when there is a tag' do
      let(:tag) { create(:journal_tag) }

      before do
        tag
      end

      it "returns http success" do
        get :show, tag: 'tag'
        expect(response).to have_http_status(:success)
        expect(assigns :tag).to eql tag
      end

    end

  end

end
