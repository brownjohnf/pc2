require 'spec_helper'

describe "site_configs/index" do
  before(:each) do
    assign(:site_configs, [
      stub_model(SiteConfig,
        :name => "Name",
        :setting => "Setting",
        :description => "MyText"
      ),
      stub_model(SiteConfig,
        :name => "Name",
        :setting => "Setting",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of site_configs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Setting".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
