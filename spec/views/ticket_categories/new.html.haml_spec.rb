require 'spec_helper'

describe "ticket_categories/new" do
  before(:each) do
    assign(:ticket_category, stub_model(TicketCategory,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new ticket_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ticket_categories_path, :method => "post" do
      assert_select "input#ticket_category_name", :name => "ticket_category[name]"
    end
  end
end
