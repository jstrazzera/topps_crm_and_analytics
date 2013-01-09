# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ab_test_cach, :class => 'AbTestCache' do
    test_name "MyString"
    app "MyString"
    fan_id 1
    group "MyString"
    success false
  end
end
