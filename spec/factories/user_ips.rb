# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_ip do
    user_id 1
    ip "MyString"
  end
end
