# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Malkav"
    email "test@sub.com"
    password "qwsazx"
    password_confirmation "qwsazx"
    activation_state "active"

    factory :admin do
      group "admins"
    end
  end
end
