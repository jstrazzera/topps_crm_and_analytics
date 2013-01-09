require 'spec_helper'

describe "message_logs/show" do
  before(:each) do
    @message_log = assign(:message_log, stub_model(MessageLog,
      :method => "Method",
      :kind => "Kind",
      :fan_id => 1,
      :success => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Method/)
    rendered.should match(/Kind/)
    rendered.should match(/1/)
    rendered.should match(/false/)
  end
end
