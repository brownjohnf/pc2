require 'spec_helper'

describe "ticket_codes/index" do
  before(:each) do
    assign(:ticket_codes, [
      stub_model(TicketCode,
        :name => "Name",
        :description => "Description",
        :color => "Color",
        :sender => false,
        :receiver => false,
        :rank => 1
      ),
      stub_model(TicketCode,
        :name => "Name",
        :description => "Description",
        :color => "Color",
        :sender => false,
        :receiver => false,
        :rank => 1
      )
    ])
  end

  it "renders a list of ticket_codes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
