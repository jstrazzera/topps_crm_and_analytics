require 'spec_helper'

describe "email_templates/index" do
  before(:each) do
    assign(:email_templates, [
      stub_model(EmailTemplate,
        :email_type => "Email Type",
        :subject => "Subject",
        :body => "Body"
      ),
      stub_model(EmailTemplate,
        :email_type => "Email Type",
        :subject => "Subject",
        :body => "Body"
      )
    ])
  end

  it "renders a list of email_templates" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email Type".to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
  end
end
