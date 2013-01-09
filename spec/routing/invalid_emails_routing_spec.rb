require "spec_helper"

describe InvalidEmailsController do
  describe "routing" do

    it "routes to #index" do
      get("/invalid_emails").should route_to("invalid_emails#index")
    end

    it "routes to #new" do
      get("/invalid_emails/new").should route_to("invalid_emails#new")
    end

    it "routes to #show" do
      get("/invalid_emails/1").should route_to("invalid_emails#show", :id => "1")
    end

    it "routes to #edit" do
      get("/invalid_emails/1/edit").should route_to("invalid_emails#edit", :id => "1")
    end

    it "routes to #create" do
      post("/invalid_emails").should route_to("invalid_emails#create")
    end

    it "routes to #update" do
      put("/invalid_emails/1").should route_to("invalid_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/invalid_emails/1").should route_to("invalid_emails#destroy", :id => "1")
    end

  end
end
