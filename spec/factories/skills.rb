FactoryGirl.define do
  factory :skill do
    name {"MySkill#{rand(99)}"}
    skill_type 'phisic'
  end
end