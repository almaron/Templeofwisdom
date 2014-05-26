# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_comment do
    blog_post_id 1
    comment "MyComment"
    user_id 1
  end
end
