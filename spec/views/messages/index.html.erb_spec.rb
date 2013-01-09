require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :attempted => false,
        :success => false,
        :type => "Type",
        :message => "Message",
        :batch_id => "Batch"
      ),
      stub_model(Message,
        :attempted => false,
        :success => false,
        :type => "Type",
        :message => "Message",
        :batch_id => "Batch"
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
    assert_select "tr>td", :text => "Batch".to_s, :count => 2
  end
end
