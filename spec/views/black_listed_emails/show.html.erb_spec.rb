require 'spec_helper'

describe "black_listed_emails/show" do
  before(:each) do
    @black_listed_email = assign(:black_listed_email, stub_model(BlackListedEmail,
      :type => "Type",
      :address => "Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    rendered.should match(/Address/)
  end
end
