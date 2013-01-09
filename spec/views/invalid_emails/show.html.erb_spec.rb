require 'spec_helper'

describe "invalid_emails/show" do
  before(:each) do
    @invalid_email = assign(:invalid_email, stub_model(InvalidEmail,
      :address => "Address",
      :reason => "Reason"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    rendered.should match(/Reason/)
  end
end
