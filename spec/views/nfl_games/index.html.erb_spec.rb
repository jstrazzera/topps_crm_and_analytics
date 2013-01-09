require 'spec_helper'

describe "nfl_games/index" do
  before(:each) do
    assign(:nfl_games, [
      stub_model(NflGame,
        :team_1_id => 1,
        :team_2_id => 2
      ),
      stub_model(NflGame,
        :team_1_id => 1,
        :team_2_id => 2
      )
    ])
  end

  it "renders a list of nfl_games" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
