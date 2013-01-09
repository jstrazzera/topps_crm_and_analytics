require "spec_helper"

describe BlackListedEmailsController do
  describe "routing" do

    it "routes to #index" do
      get("/black_listed_emails").should route_to("black_listed_emails#index")
    end

    it "routes to #new" do
      get("/black_listed_emails/new").should route_to("black_listed_emails#new")
    end

    it "routes to #show" do
      get("/black_listed_emails/1").should route_to("black_listed_emails#show", :id => "1")
    end

    it "routes to #edit" do
      get("/black_listed_emails/1/edit").should route_to("black_listed_emails#edit", :id => "1")
    end

    it "routes to #create" do
      post("/black_listed_emails").should route_to("black_listed_emails#create")
    end

    it "routes to #update" do
      put("/black_listed_emails/1").should route_to("black_listed_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/black_listed_emails/1").should route_to("black_listed_emails#destroy", :id => "1")
    end

  end
end
