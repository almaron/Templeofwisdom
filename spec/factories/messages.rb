# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    user_id 1
    char_id 1
    head "MyString"
    text "MyText"
    deleted 0
  end
end
