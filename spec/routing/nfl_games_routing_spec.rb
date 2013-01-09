require "spec_helper"

describe NflGamesController do
  describe "routing" do

    it "routes to #index" do
      get("/nfl_games").should route_to("nfl_games#index")
    end

    it "routes to #new" do
      get("/nfl_games/new").should route_to("nfl_games#new")
    end

    it "routes to #show" do
      get("/nfl_games/1").should route_to("nfl_games#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nfl_games/1/edit").should route_to("nfl_games#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nfl_games").should route_to("nfl_games#create")
    end

    it "routes to #update" do
      put("/nfl_games/1").should route_to("nfl_games#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nfl_games/1").should route_to("nfl_games#destroy", :id => "1")
    end

  end
end
