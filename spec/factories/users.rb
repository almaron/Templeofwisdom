# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Malkav"
    email "test@sub.com"
    password "qwsazx"
    password_confirmation "qwsazx"

    factory :admin do
      group "admin"
    end
  end
end
