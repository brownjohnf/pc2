require 'spec_helper'

describe "ticket_categories/show" do
  before(:each) do
    @ticket_category = assign(:ticket_category, stub_model(TicketCategory,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
