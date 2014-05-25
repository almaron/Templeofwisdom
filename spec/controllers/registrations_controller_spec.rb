require 'spec_helper'

describe RegistrationsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'activate'" do
    it "returns http success" do
      get 'activate'
      response.should be_success
    end
  end

end
