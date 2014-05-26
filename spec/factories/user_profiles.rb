# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile do
    full_name "Илья Левин"
    birth_date "1987-02-24"
    icq "23872276"
    skype "almaron_eldi"
    viewcontacts 1

    factory :user_profile_closed do
      viewcontacts 0
    end

  end


end
