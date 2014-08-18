# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill_level do
    skill_id 1
    level_id 1
    description "MyText"
    techniques "MyText"
    advice "MyText"
  end
end
