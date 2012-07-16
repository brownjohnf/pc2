require 'spec_helper'

describe "ticket_updates/index" do
  before(:each) do
    assign(:ticket_updates, [
      stub_model(TicketUpdate,
        :ticket_id => 1,
        :ticket_code_id => 2,
        :comment => "Comment",
        :user_id => 3
      ),
      stub_model(TicketUpdate,
        :ticket_id => 1,
        :ticket_code_id => 2,
        :comment => "Comment",
        :user_id => 3
      )
    ])
  end

  it "renders a list of ticket_updates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
