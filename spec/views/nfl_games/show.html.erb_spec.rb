require 'spec_helper'

describe "nfl_games/show" do
  before(:each) do
    @nfl_game = assign(:nfl_game, stub_model(NflGame,
      :team_1_id => 1,
      :team_2_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
