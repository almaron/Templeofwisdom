# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :char_profile do
    char_id 1
    birth_date "25.04"
    age 45
    points 0

    factory :real_age_profile do
      real_age 45
      season_id 2
    end
  end
end
