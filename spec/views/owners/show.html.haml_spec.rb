require 'spec_helper'

describe "owners/show" do
  before(:each) do
    @owner = assign(:owner, stub_model(Owner,
      :from_id => 1,
      :to_id => 2,
      :ticket_id => 3,
      :code_id => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end
