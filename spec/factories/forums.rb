# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum do
    name "MyForum"
    ancestry nil

    factory :child_forum do
      ancestry "1"
    end

  end
end
