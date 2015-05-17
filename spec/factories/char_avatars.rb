FactoryGirl.define do
  factory :char_avatar do
    char_id 1
    image "MyString"
    default false

    factory :default_avatar do
      default true
    end
  end
end
