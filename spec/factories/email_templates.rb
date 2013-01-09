# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email_template do
    email_type "MyString"
    subject "MyString"
    body "MyString"
  end
end
