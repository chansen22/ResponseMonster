require 'spec_helper'

describe Course do
  before { @course = Course.new(name: "Test Course",
                                title: "Test Title",
                                section: "01",
                                term: Date.today) }
  subject { @course }

  it { should respond_to(:name) }
  it { should respond_to(:title) }
  it { should respond_to(:section) }
  it { should respond_to(:term) }

  it { should be_valid }

  describe "when a name is invalid" do
    describe "when a name is not present" do
      before { @course.name = "" }
      it { should_not be_valid }
    end
  end

  describe "when a title is invalid" do
    describe "when a title is not present" do
      before { @course.title = "" }
      it { should_not be_valid }
    end
  end
end
