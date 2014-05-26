# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest_post do
    head "Head"
    content "Some question about nonsense?"
    user "Albert"

    factory :answered_post do
      answer "Some answer from the admins."
    end
  end
end
