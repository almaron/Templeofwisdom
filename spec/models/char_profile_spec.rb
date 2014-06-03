require 'spec_helper'

describe CharProfile do

  describe "real_age" do

    before :each do
      @conf = AdminConfig.create(name: "current_year", value: "3")
      @profile = create :char_profile
      @set = attributes_for :char_profile
    end

    it "should not change the age on create" do
      expect(@profile.real_age).to eql(@set[:real_age])
    end

    it "should change the age on aging" do
      @conf.update(value:"6")
      expect(@profile.real_age - @set[:real_age]).to eql(3)
    end

  end

end
