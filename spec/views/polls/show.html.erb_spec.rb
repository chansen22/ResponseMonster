require 'spec_helper'

describe "polls/show" do
  before(:each) do
    @poll = assign(:poll, stub_model(Poll,
      :type => "Type",
      :question => "Question"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Type/)
    rendered.should match(/Question/)
  end
end
