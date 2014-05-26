require 'spec_helper'

describe PagesController do
  it "routes the :url to a page" do
    {get: "/pages/sample_page"}.should route_to(controller: "pages", action: "show", url: "sample_page")
  end
end