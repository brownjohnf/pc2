require 'spec_helper'

describe "tickets/edit" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :ref_id => 1,
      :ticket_category_id => 1,
      :subject => "MyString",
      :body => "MyString",
      :priority_id => 1
    ))
  end

  it "renders the edit ticket form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tickets_path(@ticket), :method => "post" do
      assert_select "input#ticket_ref_id", :name => "ticket[ref_id]"
      assert_select "input#ticket_ticket_category_id", :name => "ticket[ticket_category_id]"
      assert_select "input#ticket_subject", :name => "ticket[subject]"
      assert_select "input#ticket_body", :name => "ticket[body]"
      assert_select "input#ticket_priority_id", :name => "ticket[priority_id]"
    end
  end
end
