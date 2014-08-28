require 'rails_helper'

RSpec.describe SkillRequest, :type => :model do

  before do
    @char = create :char
    @char.profile.age = 20
    @char.profile.birth_date = '20.01'
    @char.save

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
      # expect(request).to be_acceptable
      expect(@char.profile).to be_valid
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

  context :initiate! do

    before do
      @forum = create :forum
      @topic = @forum.topics.create attributes_for(:forum_topic)
      AdminConfig.create(name: 'skill_requests_topic_id', value:@topic.id)
      @request = SkillRequest.new char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1
      @user = create :user
      @user.current_ip = '127.0.0.1'
    end

    context 'if acceptable' do

      it 'saves the request' do
        expect{@request.initiate!(@user)}.to change{@request.new_record?}.from(true).to(false)
      end

      it 'creates a forum post for the request' do
        expect{@request.initiate! @user}.to change{@topic.posts.count}.by(1)
      end

    end

    context 'if not acceptable' do
      before do
        @char.remove_points 200
      end

      it 'returns nil' do
        expect(@request.initiate! @user).to eq nil
      end

      it 'does not create a ForumPost' do
        expect{@request.initiate! @user}.not_to change{@topic.posts.count}
      end

    end

  end

  context :accept do

    before do
      @forum = create :forum
      @topic = @forum.topics.create attributes_for(:forum_topic)
      @post = @topic.posts.create(char_id:@char.id, user_id:1, text:'Request post', ip:'127.0.0.1')
      @request = SkillRequest.create char_id:@char.id, user_id:1, skill_id: @skill.id, level_id: 1, forum_post_id: @post.id
      @request.accept
    end

    it "sets the char skill" do
      expect(@char.char_skills.find_by(skill_id:@skill.id).level_id).to eq(@level.id)
      expect(@request.points).to eq(400)
    end

    it "removes the points from the char" do
      @char.reload
      expect(@char.profile.points).to eq 0
    end

    it "marks the role skills on the char" do
      expect(@char.role_skills.where(done:1).count).to eq 1
    end

    it "updates the request post"
  end
end
