require 'spec_helper'

describe "site_configs/edit" do
  before(:each) do
    @site_config = assign(:site_config, stub_model(SiteConfig,
      :name => "MyString",
      :setting => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit site_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => site_configs_path(@site_config), :method => "post" do
      assert_select "input#site_config_name", :name => "site_config[name]"
      assert_select "input#site_config_setting", :name => "site_config[setting]"
      assert_select "textarea#site_config_description", :name => "site_config[description]"
    end
  end
end
