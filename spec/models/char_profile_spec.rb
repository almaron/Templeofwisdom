require 'rails_helper'

describe CharProfile, :type => :model do

  describe "real_age" do

    before :each do
      @conf = AdminConfig.create(name: "current_year", value: "3")
      @profile = build :char_profile
      @set = attributes_for :char_profile
    end

    it "should not change the age on create" do
      expect(@profile.real_age).to eql(@set[:real_age])
    end

    it "should set age properly" do
      expect(@profile.real_age).to eql(@set[:real_age])
    end

    it "should set proper age direactly" do
      @profile.real_age = 54
      expect(@profile.real_age).to eql(54)
    end

    it "should change the age on aging" do
      @conf.update(value:"6")
      expect(@profile.real_age - @set[:real_age]).to eql(3)
    end

  end

end
