require 'spec_helper'

describe "SiteConfigs" do
  describe "GET /site_configs" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get site_configs_path
      response.status.should be(200)
    end
  end
end
