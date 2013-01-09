require 'spec_helper'

describe "messages/show" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :attempted => false,
      :success => false,
      :type => "Type",
      :message => "Message",
      :batch_id => "Batch"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/Type/)
    rendered.should match(/Message/)
    rendered.should match(/Batch/)
  end
end
