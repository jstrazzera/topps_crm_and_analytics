require 'spec_helper'

describe "invalid_emails/index" do
  before(:each) do
    assign(:invalid_emails, [
      stub_model(InvalidEmail,
        :address => "Address",
        :reason => "Reason"
      ),
      stub_model(InvalidEmail,
        :address => "Address",
        :reason => "Reason"
      )
    ])
  end

  it "renders a list of invalid_emails" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Reason".to_s, :count => 2
  end
end
