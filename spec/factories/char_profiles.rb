# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :char_profile do
    char_id 1
    birth_date "25.04"
    real_age 45
    season_id 2
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
    points 40
  end
end
