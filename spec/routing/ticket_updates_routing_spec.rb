require "spec_helper"

describe TicketUpdatesController do
  describe "routing" do

    it "routes to #index" do
      get("/ticket_updates").should route_to("ticket_updates#index")
    end

    it "routes to #new" do
      get("/ticket_updates/new").should route_to("ticket_updates#new")
    end

    it "routes to #show" do
      get("/ticket_updates/1").should route_to("ticket_updates#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ticket_updates/1/edit").should route_to("ticket_updates#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ticket_updates").should route_to("ticket_updates#create")
    end

    it "routes to #update" do
      put("/ticket_updates/1").should route_to("ticket_updates#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ticket_updates/1").should route_to("ticket_updates#destroy", :id => "1")
    end

  end
end
