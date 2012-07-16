require 'spec_helper'

describe "ticket_codes/show" do
  before(:each) do
    @ticket_code = assign(:ticket_code, stub_model(TicketCode,
      :name => "Name",
      :description => "Description",
      :color => "Color",
      :sender => false,
      :receiver => false,
      :rank => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Description/)
    rendered.should match(/Color/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/1/)
  end
end
