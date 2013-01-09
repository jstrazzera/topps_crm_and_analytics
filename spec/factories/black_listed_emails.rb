# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :black_listed_email do
    type ""
    address "MyString"
  end
end
