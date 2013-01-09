# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invalid_email do
    address "MyString"
    reason "MyString"
    date "2012-08-21 14:07:48"
  end
end
