require 'spec_helper'

describe PagesController, :type => :routing do
  it "routes the :url to a page" do
    expect({get: "/pages/sample_page"}).to route_to(controller: "pages", action: "show", url: "sample_page")
  end
end