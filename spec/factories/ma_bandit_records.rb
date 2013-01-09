# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ma_bandit_record do
    m_a_bandit_key 1
    fan_id 1
    success false
    group "MyString"
  end
end
