require 'spec_helper'

describe "tickets/show" do
  before(:each) do
    @ticket = assign(:ticket, stub_model(Ticket,
      :ref_id => 1,
      :ticket_category_id => 2,
      :subject => "Subject",
      :body => "Body",
      :priority_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Subject/)
    rendered.should match(/Body/)
    rendered.should match(/3/)
  end
end
