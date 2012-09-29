require 'spec_helper'

describe SurveysController do
  render_views
   before { @user = User.create!(first_name: "Test",
                                 last_name: "User", 
                                 email: "test@test.com",
                                 password: "password",
                                 password_confirmation: "password" ) }
 
  before { @course = Course.create!(name: "Test Course",
                                    title: "Test Title",
                                    section: "01",
                                    term: Date.today) }

  before { @survey = @course.surveys.create!(name: "Test Survey",
                                             start_time: Time.now,
                                             end_time: Time.now,
                                             is_active: true) }
  subject { @survey }

  describe "GET show"
end