# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :analytics_cach, :class => 'AnalyticsCache' do
    kind "MyString"
    time "2012-11-09 14:04:21"
    int_data 1
  end
end
