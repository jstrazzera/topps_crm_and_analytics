require 'spec_helper'

describe "message_logs/edit" do
  before(:each) do
    @message_log = assign(:message_log, stub_model(MessageLog,
      :method => "MyString",
      :kind => "MyString",
      :fan_id => 1,
      :success => false
    ))
  end

  it "renders the edit message_log form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => message_logs_path(@message_log), :method => "post" do
      assert_select "input#message_log_method", :name => "message_log[method]"
      assert_select "input#message_log_kind", :name => "message_log[kind]"
      assert_select "input#message_log_fan_id", :name => "message_log[fan_id]"
      assert_select "input#message_log_success", :name => "message_log[success]"
    end
  end
end
