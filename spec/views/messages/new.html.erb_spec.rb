require 'spec_helper'

describe "messages/new" do
  before(:each) do
    assign(:message, stub_model(Message,
      :attempted => false,
      :success => false,
      :type => "",
      :message => "MyString",
      :batch_id => "MyString"
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "input#message_attempted", :name => "message[attempted]"
      assert_select "input#message_success", :name => "message[success]"
      assert_select "input#message_type", :name => "message[type]"
      assert_select "input#message_message", :name => "message[message]"
      assert_select "input#message_batch_id", :name => "message[batch_id]"
    end
  end
end
