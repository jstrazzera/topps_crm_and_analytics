require 'spec_helper'

describe "invalid_emails/edit" do
  before(:each) do
    @invalid_email = assign(:invalid_email, stub_model(InvalidEmail,
      :address => "MyString",
      :reason => "MyString"
    ))
  end

  it "renders the edit invalid_email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => invalid_emails_path(@invalid_email), :method => "post" do
      assert_select "input#invalid_email_address", :name => "invalid_email[address]"
      assert_select "input#invalid_email_reason", :name => "invalid_email[reason]"
    end
  end
end
