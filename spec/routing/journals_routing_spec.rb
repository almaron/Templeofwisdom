require 'rails_helper'

describe 'Journals routing', type: :routing do
  it 'should route /journals to journals#index' do
    expect(get: '/journals').to route_to(controller: 'journals', action: 'index')
  end

  it 'should route /journals/1 to journals#show' do
    expect(get: '/journals/1').to route_to(controller: 'journals', action: 'show', id: "1")
  end

  it 'should route /journals/tag/1 to tags#show' do
    expect(get: '/journals/tag/1').to route_to(controller: 'journal_tags', action: 'show', tag:'1')
  end
end