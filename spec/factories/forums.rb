# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum do
    name "MyForum"
    ancestry nil
    is_category 1

    factory :child_forum do
      ancestry "1"
    end

    trait :not_category do
      is_category 0
    end

  end
end
