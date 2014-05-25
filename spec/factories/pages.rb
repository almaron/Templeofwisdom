# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    head "MyString"
    page_title "MyString"
    page_alias "MyString"
    ancestry "MyString"
    content "MyText"
    partial "MyString"
    partial_params "MyString"
    published 1
    hide_menu 1
    sorting 1
    meta_title "MyString"
    meta_description "MyString"
    meta_keywords "MyString"
  end
end
