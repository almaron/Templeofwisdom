# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    sequence(:head, aliases:[:page_title]) {|n| "Sample page #{n}"}
    sequence(:page_alias) {|n| "page_#{n}" }
    content "Sample_content"
    published 1
  end
end
