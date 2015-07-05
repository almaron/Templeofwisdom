FactoryGirl.define do
  factory :master_answer do
    question_id 1
    user_id 1
    text 'some wise advice'
    answer_status 'master'
  end

end
