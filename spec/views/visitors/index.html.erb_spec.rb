require 'spec_helper'

describe "visitors/index" do
  before(:each) do
    assign(:visitors, [
      stub_model(Visitor,
        :email => "Email"
      ),
      stub_model(Visitor,
        :email => "Email"
      )
    ])
  end

  it "renders a list of visitors" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
