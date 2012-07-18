require 'spec_helper'

describe "tickets/index" do
  before(:each) do
    assign(:tickets, [
      stub_model(Ticket,
        :ref_id => 1,
        :ticket_category_id => 2,
        :subject => "Subject",
        :body => "Body",
        :priority_id => 3
      ),
      stub_model(Ticket,
        :ref_id => 1,
        :ticket_category_id => 2,
        :subject => "Subject",
        :body => "Body",
        :priority_id => 3
      )
    ])
  end

  it "renders a list of tickets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
