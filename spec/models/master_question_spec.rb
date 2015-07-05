require 'rails_helper'

RSpec.describe MasterQuestion, type: :model do
  it 'should be valid' do
    q = build :master_question
    expect(q).to be_valid
  end
end
