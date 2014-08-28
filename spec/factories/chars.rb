# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :char do
    name "She Bao"
    group_id 3
    status_line "Настоятель"
    avatar ""
    status_id 2
    open_player ""
    profile_topic_id 1
    # profile_attributes {[age: 20, birth_date: "20.01"]}
  end
end
