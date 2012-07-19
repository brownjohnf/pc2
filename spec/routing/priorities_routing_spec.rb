require "spec_helper"

describe PrioritiesController do
  describe "routing" do

    it "routes to #index" do
      get("/priorities").should route_to("priorities#index")
    end

    it "routes to #new" do
      get("/priorities/new").should route_to("priorities#new")
    end

    it "routes to #show" do
      get("/priorities/1").should route_to("priorities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/priorities/1/edit").should route_to("priorities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/priorities").should route_to("priorities#create")
    end

    it "routes to #update" do
      put("/priorities/1").should route_to("priorities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/priorities/1").should route_to("priorities#destroy", :id => "1")
    end

  end
end
