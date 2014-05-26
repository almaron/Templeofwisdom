# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :char_delegation do
    char_id 1
    user_id 1
    ending "2014-05-26"
    owner 1
    default 1
  end
end
