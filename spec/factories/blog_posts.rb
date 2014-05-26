# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_post do
    head "MyString head"
    text "MyText some text to be in the blogpost"
    author "Author"
  end
end
