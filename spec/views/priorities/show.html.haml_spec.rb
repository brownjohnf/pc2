require 'spec_helper'

describe "priorities/show" do
  before(:each) do
    @priority = assign(:priority, stub_model(Priority,
      :level => 1,
      :name => "Name",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Name/)
    rendered.should match(/Description/)
  end
end
