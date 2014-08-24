# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_request do
    user_id 1
    char_id 1
    skill_id 1
    level_id 1
    forum_post_id 1
  end
end
