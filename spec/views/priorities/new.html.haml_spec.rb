require 'spec_helper'

describe "priorities/new" do
  before(:each) do
    assign(:priority, stub_model(Priority,
      :level => 1,
      :name => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new priority form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => priorities_path, :method => "post" do
      assert_select "input#priority_level", :name => "priority[level]"
      assert_select "input#priority_name", :name => "priority[name]"
      assert_select "input#priority_description", :name => "priority[description]"
    end
  end
end
