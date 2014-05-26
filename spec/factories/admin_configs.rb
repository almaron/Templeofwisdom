# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_config do
    name "string"
    value "value"
  end

  factory :int_config, class: AdminConfig do
    name "int"
    value "12345"
  end
end
