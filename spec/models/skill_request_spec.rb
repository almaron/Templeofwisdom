require 'rails_helper'

RSpec.describe SkillRequest, :type => :model do

  before do
    @char = Char.create attributes_for(:char)
    @char.create_profile
    @char.add_points 400
    @skill = create :skill
    @level = Level.create(id:1, name:'Level1', phisic_roles:1, phisic_points: 400, phisic_points_discount: 200)
    @role = Role.create(attributes_for(:role).merge(char_roles_attributes:[char_id: @char.id, points:400, role_skills_attributes:[skill_id:@skill.id]]))

  end

  context 'after initialize' do
    it "creates a valid request" do
      request = SkillRequest.new char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1
      expect(request).to be_valid
    end

    it "calculates the required roles and points" do
      request = SkillRequest.new char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1
      expect(request.points).to eq(400)
      expect(request.roles).to eq(1)
    end
  end

  context :acceptable? do

    it "should be acceptable if the character has enough" do
      request = SkillRequest.new char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1
      expect(request).to be_acceptable
    end

    it "should not be acceptable if requires more points" do
      @level.update(phisic_points:600)
      request = SkillRequest.new char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1
      expect(request).not_to be_acceptable
    end

    it "should not be acceptable if requires more roles" do
      @level.update(phisic_roles:4)
      request = SkillRequest.new char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1
      expect(request).not_to be_acceptable
    end
  end

  context :accept do

    it "sets the char skill"

    it "removes the points from the char"

    it "marks the role skills on the char"

    it "updates the request post"
  end
end
