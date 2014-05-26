# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :char_profile do
    char_id 1
    bdate "MyString"
    age 1
    season_id 1
    place "MyString"
    beast "MyString"
    phisics "MyText"
    bio "MyText"
    look "MyText"
    character "MyText"
    items "MyText"
    other "MyText"
    person "MyString"
    comment "MyText"
    balls 1
  end
end
