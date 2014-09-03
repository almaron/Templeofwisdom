require 'rails_helper'

RSpec.describe JournalPage, :type => :model do

  describe :content_blocks do

    it "should have 3 blocks" do
      page = build :journal_page
      expect(page.content_blocks.size).to eq 3
    end

    it "should have no blocks if blank" do
      page = JournalPage.new
      expect(page.content_blocks.size).to eq 0
    end

    it "should have 1 block if no separators" do
      page = JournalPage.new(content_text:"Some Dummy Text")
      expect(page.content_blocks.size).to eq 1
      expect(page.content_blocks[0]).to eq page.content_text
    end

  end

  describe :content_blocks= do

    before do
      @blocks = ["Some Dummy Text", "Second Dummy Text"]
      @page = JournalPage.new
    end

    it "should set an empty string if the array is empty" do
      @page.content_blocks = []
      expect(@page.content_text).to eq ""
    end

    it "should set the content_text" do
      @page.content_blocks = @blocks
      expect(@page.content_text).to be_present
    end

    it "should concat the blocks with a separator" do
      @page.content_blocks = @blocks
      expect(@page.content_text).to eq @blocks.join('|&|')
    end

    it "should ignore the empty and nil items in blocks" do
      @blocks += [nil, ""]
      @page.content_blocks = @blocks
      expect(@page.content_text).to eq "#{@blocks[0]}|&|#{@blocks[1]}"
    end

  end

end
