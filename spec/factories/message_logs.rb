# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message_log do
    method "MyString"
    kind "MyString"
    fan_id 1
    success false
  end
end
