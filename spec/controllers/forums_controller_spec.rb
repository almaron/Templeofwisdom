require 'rails_helper'

describe ForumsController, :type => :controller do

  describe 'GET #index' do
    before :each do
      create_list :forum, 4
    end

    describe 'AS html' do
      before do
        get :index, format: :html
      end

      it 'should return ok' do
        expect(response.status).to eql(200)
      end

      it 'should render the view' do
        expect(response).to render_template('index')
      end

      it 'should not assign forums' do
        expect(assigns(:forums)).to be_nil
      end
    end

    describe 'AS json' do
      before do
        get :index, format: :json
      end

      it 'should return ok' do
        expect(response.status).to eql(200)
      end

      it 'should assign forums' do
        expect(assigns(:forums).size).to eql 4
      end
    end
  end

end
