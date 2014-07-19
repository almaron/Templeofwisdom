require 'rails_helper'

describe News do

  it "should be valid" do
    news = build_stubbed :news
    expect(news).to be_valid
  end

end

