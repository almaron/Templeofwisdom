# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role_app do
    head "MyString"
    paths "MyText"
    user_id 1
  end
end
