require 'spec_helper'

describe "black_listed_emails/index" do
  before(:each) do
    assign(:black_listed_emails, [
      stub_model(BlackListedEmail,
        :type => "Type",
        :address => "Address"
      ),
      stub_model(BlackListedEmail,
        :type => "Type",
        :address => "Address"
      )
    ])
  end

  it "renders a list of black_listed_emails" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
  end
end
