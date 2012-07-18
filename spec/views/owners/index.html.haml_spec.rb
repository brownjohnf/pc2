require 'spec_helper'

describe "owners/index" do
  before(:each) do
    assign(:owners, [
      stub_model(Owner,
        :from_id => 1,
        :to_id => 2,
        :ticket_id => 3,
        :code_id => 4
      ),
      stub_model(Owner,
        :from_id => 1,
        :to_id => 2,
        :ticket_id => 3,
        :code_id => 4
      )
    ])
  end

  it "renders a list of owners" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end
