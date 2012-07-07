require "spec_helper"

describe SiteConfigsController do
  describe "routing" do

    it "routes to #index" do
      get("/site_configs").should route_to("site_configs#index")
    end

    it "routes to #new" do
      get("/site_configs/new").should route_to("site_configs#new")
    end

    it "routes to #show" do
      get("/site_configs/1").should route_to("site_configs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/site_configs/1/edit").should route_to("site_configs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/site_configs").should route_to("site_configs#create")
    end

    it "routes to #update" do
      put("/site_configs/1").should route_to("site_configs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/site_configs/1").should route_to("site_configs#destroy", :id => "1")
    end

  end
end
