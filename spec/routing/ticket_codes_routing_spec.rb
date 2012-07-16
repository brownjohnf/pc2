require "spec_helper"

describe TicketCodesController do
  describe "routing" do

    it "routes to #index" do
      get("/ticket_codes").should route_to("ticket_codes#index")
    end

    it "routes to #new" do
      get("/ticket_codes/new").should route_to("ticket_codes#new")
    end

    it "routes to #show" do
      get("/ticket_codes/1").should route_to("ticket_codes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ticket_codes/1/edit").should route_to("ticket_codes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ticket_codes").should route_to("ticket_codes#create")
    end

    it "routes to #update" do
      put("/ticket_codes/1").should route_to("ticket_codes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ticket_codes/1").should route_to("ticket_codes#destroy", :id => "1")
    end

  end
end
