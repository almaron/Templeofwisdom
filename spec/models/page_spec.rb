require 'rails_helper'

RSpec.describe Page, type: :model do

  describe :deplete! do

    before do
      @root_page = create :page
      @page = @root_page.children.create attributes_for(:page)
      (1..3).each {|i| @page.children.create attributes_for(:page)}
    end

    it "creates 3 siblings" do
      expect(@page.children.size).to eq 3
    end

    it 'deletes a page' do
      expect{@page.deplete!}.to change{Page.count}.by(-1)
    end

    it 'moves the children up the stack' do
      @page.deplete!
      expect(@root_page.children.size).to eq 3
    end
  end

end