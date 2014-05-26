# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :news do
    author "Шэ Бао"
    head "MyString Long"
    text "MyText Very very\r\n very very long edit"
  end
end
