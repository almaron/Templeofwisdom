# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    head { "MyString#{rand(99)}" }
    paths 'MyString'
  end
end
