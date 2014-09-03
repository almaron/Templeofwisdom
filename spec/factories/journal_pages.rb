# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :journal_page do
    journal_id 1
    head "MyString"
    page_type "MyString"
    content_text "First Block|&|  |&|Second Block\n\rSecond Block|&|Third Block"
    content_line "MyString"
  end
end
