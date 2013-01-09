# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :nfl_game do
    team_1_id 1
    team_2_id 1
    game_start "2012-11-16 15:01:39"
  end
end
