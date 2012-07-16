require 'spec_helper'

describe "ticket_updates/show" do
  before(:each) do
    @ticket_update = assign(:ticket_update, stub_model(TicketUpdate,
      :ticket_id => 1,
      :ticket_code_id => 2,
      :comment => "Comment",
      :user_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Comment/)
    rendered.should match(/3/)
  end
end
