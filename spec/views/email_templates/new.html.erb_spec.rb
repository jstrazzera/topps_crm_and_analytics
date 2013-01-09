require 'spec_helper'

describe "email_templates/new" do
  before(:each) do
    assign(:email_template, stub_model(EmailTemplate,
      :email_type => "MyString",
      :subject => "MyString",
      :body => "MyString"
    ).as_new_record)
  end

  it "renders new email_template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => email_templates_path, :method => "post" do
      assert_select "input#email_template_email_type", :name => "email_template[email_type]"
      assert_select "input#email_template_subject", :name => "email_template[subject]"
      assert_select "input#email_template_body", :name => "email_template[body]"
    end
  end
end
