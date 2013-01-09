require 'spec_helper'

describe "black_listed_emails/edit" do
  before(:each) do
    @black_listed_email = assign(:black_listed_email, stub_model(BlackListedEmail,
      :type => "",
      :address => "MyString"
    ))
  end

  it "renders the edit black_listed_email form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => black_listed_emails_path(@black_listed_email), :method => "post" do
      assert_select "input#black_listed_email_type", :name => "black_listed_email[type]"
      assert_select "input#black_listed_email_address", :name => "black_listed_email[address]"
    end
  end
end
