require 'spec_helper'

describe "nfl_games/new" do
  before(:each) do
    assign(:nfl_game, stub_model(NflGame,
      :team_1_id => 1,
      :team_2_id => 1
    ).as_new_record)
  end

  it "renders new nfl_game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nfl_games_path, :method => "post" do
      assert_select "input#nfl_game_team_1_id", :name => "nfl_game[team_1_id]"
      assert_select "input#nfl_game_team_2_id", :name => "nfl_game[team_2_id]"
    end
  end
end
