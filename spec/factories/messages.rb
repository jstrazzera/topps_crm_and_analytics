# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    attempted false
    success false
    type ""
    message "MyString"
    batch_id "MyString"
  end
end
