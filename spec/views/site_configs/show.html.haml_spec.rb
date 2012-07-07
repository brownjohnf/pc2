require 'spec_helper'

describe "site_configs/show" do
  before(:each) do
    @site_config = assign(:site_config, stub_model(SiteConfig,
      :name => "Name",
      :setting => "Setting",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Setting/)
    rendered.should match(/MyText/)
  end
end
