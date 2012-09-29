require 'spec_helper'

describe Survey do
  before { @course = Course.new(name: "Test Course",
                                title: "Test Title",
                                section: "01",
                                term: Date.today) }
  before { @survey = @course.surveys.new(name: "Test Survey",
                                         start_time: Time.now,
                                         end_time: Time.now,
                                         is_active: true) }
  subject { @survey }

  it { should respond_to(:name) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should respond_to(:is_active) }

  it { should be_valid }

  describe "when a name is valid" do
    describe "when a name is not present" do
      before { @survey.name = "" }
      it { should be_valid }
    end

    describe "when a name is present" do
      it { should be_valid }
    end
  end
end
