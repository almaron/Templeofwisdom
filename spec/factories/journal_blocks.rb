# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journal_block do
    page_id 1
    content "MyText"
    image "MyString"
  end
end
