require "spec_helper"

describe TicketCategoriesController do
  describe "routing" do

    it "routes to #index" do
      get("/ticket_categories").should route_to("ticket_categories#index")
    end

    it "routes to #new" do
      get("/ticket_categories/new").should route_to("ticket_categories#new")
    end

    it "routes to #show" do
      get("/ticket_categories/1").should route_to("ticket_categories#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ticket_categories/1/edit").should route_to("ticket_categories#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ticket_categories").should route_to("ticket_categories#create")
    end

    it "routes to #update" do
      put("/ticket_categories/1").should route_to("ticket_categories#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ticket_categories/1").should route_to("ticket_categories#destroy", :id => "1")
    end

  end
end
