# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    head "Sample page"
    page_title "Sample_page"
    page_alias "sample"
    content "Sample_content"
    published 1
    meta_title "Sample page title"
  end
end
