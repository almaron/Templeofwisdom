# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :log do
    user_id 1
    type_id 1
    text "MyString"
  end
end
