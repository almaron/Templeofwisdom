require 'rails_helper'

RSpec.describe CharAvatar, type: :model do

  describe 'on create' do
    before :each do
      @char = create :char
    end

    it 'should be a valid avatar' do
      avatar = create :char_avatar, char_id: @char.id
      expect(avatar).to be_a CharAvatar
      expect(avatar).to be_valid
    end

    it 'should set itself as default if the first one' do
      avatar = create :char_avatar, char_id: @char.id
      expect(@char.default_avatar).to eql avatar
    end

    it 'should set itself as default if default' do
      create :char_avatar, char_id: @char.id
      avatar = create :default_avatar, char_id: @char.id
      expect(@char.default_avatar).to eql avatar
    end

    it 'should not set itself default if default present and not default itself' do
      avatar = create :char_avatar, char_id: @char.id
      create :char_avatar, char_id: @char.id
      expect(@char.default_avatar).to eql avatar
    end
  end
end
