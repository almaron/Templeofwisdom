# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journal do
    head "MyString"
    cover "MyString"
    publish_date "2014-09-02 20:43:43"
  end
end
