require "spec_helper"

describe MessageLogsController do
  describe "routing" do

    it "routes to #index" do
      get("/message_logs").should route_to("message_logs#index")
    end

    it "routes to #new" do
      get("/message_logs/new").should route_to("message_logs#new")
    end

    it "routes to #show" do
      get("/message_logs/1").should route_to("message_logs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/message_logs/1/edit").should route_to("message_logs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/message_logs").should route_to("message_logs#create")
    end

    it "routes to #update" do
      put("/message_logs/1").should route_to("message_logs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/message_logs/1").should route_to("message_logs#destroy", :id => "1")
    end

  end
end
