require 'spec_helper'

describe "message_logs/index" do
  before(:each) do
    assign(:message_logs, [
      stub_model(MessageLog,
        :method => "Method",
        :kind => "Kind",
        :fan_id => 1,
        :success => false
      ),
      stub_model(MessageLog,
        :method => "Method",
        :kind => "Kind",
        :fan_id => 1,
        :success => false
      )
    ])
  end

  it "renders a list of message_logs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Method".to_s, :count => 2
    assert_select "tr>td", :text => "Kind".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
