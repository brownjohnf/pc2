require 'spec_helper'

describe "owners/edit" do
  before(:each) do
    @owner = assign(:owner, stub_model(Owner,
      :from_id => 1,
      :to_id => 1,
      :ticket_id => 1,
      :code_id => 1
    ))
  end

  it "renders the edit owner form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => owners_path(@owner), :method => "post" do
      assert_select "input#owner_from_id", :name => "owner[from_id]"
      assert_select "input#owner_to_id", :name => "owner[to_id]"
      assert_select "input#owner_ticket_id", :name => "owner[ticket_id]"
      assert_select "input#owner_code_id", :name => "owner[code_id]"
    end
  end
end
