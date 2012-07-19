require 'spec_helper'

describe "ticket_codes/new" do
  before(:each) do
    assign(:ticket_code, stub_model(TicketCode,
      :name => "MyString",
      :description => "MyString",
      :color => "MyString",
      :sender => false,
      :receiver => false,
      :rank => 1
    ).as_new_record)
  end

  it "renders new ticket_code form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_codes_path, :method => "post" do
      assert_select "input#ticket_code_name", :name => "ticket_code[name]"
      assert_select "input#ticket_code_description", :name => "ticket_code[description]"
      assert_select "input#ticket_code_color", :name => "ticket_code[color]"
      assert_select "input#ticket_code_sender", :name => "ticket_code[sender]"
      assert_select "input#ticket_code_receiver", :name => "ticket_code[receiver]"
      assert_select "input#ticket_code_rank", :name => "ticket_code[rank]"
    end
  end
end
