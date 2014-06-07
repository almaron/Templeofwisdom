# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :forum_post do
    text "MyText"
    char_id 1
    user_id 1
    ip "198.162.11.1"

    factory :commented_post do
      comment "Комментарий"
      commenter "Шэ"

    end
  end
end
