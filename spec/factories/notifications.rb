# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user_id 1
    head "MyString"
    text "MyText"
    read 1
  end
end
