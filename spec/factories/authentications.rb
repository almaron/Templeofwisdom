# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider "google"
    uid "almaron@gmail.com"
  end
end
