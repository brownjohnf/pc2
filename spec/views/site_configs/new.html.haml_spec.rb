require 'spec_helper'

describe "site_configs/new" do
  before(:each) do
    assign(:site_config, stub_model(SiteConfig,
      :name => "MyString",
      :setting => "MyString",
      :description => "MyText"
    ).as_new_record)
  end

  it "renders new site_config form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => site_configs_path, :method => "post" do
      assert_select "input#site_config_name", :name => "site_config[name]"
      assert_select "input#site_config_setting", :name => "site_config[setting]"
      assert_select "textarea#site_config_description", :name => "site_config[description]"
    end
  end
end
