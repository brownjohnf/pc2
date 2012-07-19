require 'spec_helper'

describe "ticket_updates/edit" do
  before(:each) do
    @ticket_update = assign(:ticket_update, stub_model(TicketUpdate,
      :ticket_id => 1,
      :ticket_code_id => 1,
      :comment => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit ticket_update form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_updates_path(@ticket_update), :method => "post" do
      assert_select "input#ticket_update_ticket_id", :name => "ticket_update[ticket_id]"
      assert_select "input#ticket_update_ticket_code_id", :name => "ticket_update[ticket_code_id]"
      assert_select "input#ticket_update_comment", :name => "ticket_update[comment]"
      assert_select "input#ticket_update_user_id", :name => "ticket_update[user_id]"
    end
  end
end
