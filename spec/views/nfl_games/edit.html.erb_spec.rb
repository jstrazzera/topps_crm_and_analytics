require 'spec_helper'

describe "nfl_games/edit" do
  before(:each) do
    @nfl_game = assign(:nfl_game, stub_model(NflGame,
      :team_1_id => 1,
      :team_2_id => 1
    ))
  end

  it "renders the edit nfl_game form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => nfl_games_path(@nfl_game), :method => "post" do
      assert_select "input#nfl_game_team_1_id", :name => "nfl_game[team_1_id]"
      assert_select "input#nfl_game_team_2_id", :name => "nfl_game[team_2_id]"
    end
  end
end
