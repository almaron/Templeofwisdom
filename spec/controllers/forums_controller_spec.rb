require 'rails_helper'

describe ForumsController, :type => :controller do

  describe 'GET #index' do
    before :each do
      create_list :forum, 4
    end

    context 'AS html' do
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

    context 'AS json' do
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

  describe 'GET #show' do
    before :each do
      create :forum, id: 1
      create_list :child_forum, 4
    end

    context 'AS html' do
      before do
        get :show, id: 1, format: :html
      end

      it 'should return ok' do
        expect(response.status).to eq(200)
      end

      it 'should render the view' do
        expect(response).to render_template('show')
      end

      it 'should fetch the forum' do
        expect(assigns :forum).to be_a Forum
        expect(assigns(:forum).id).to eql 1
      end

      it 'should fetch children' do
        expect(assigns(:forum).children.count).to eql 4
      end
    end

  end

end
