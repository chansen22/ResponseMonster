class Survey < ActiveRecord::Base
  belongs_to      :course
  has_many        :polls
  attr_accessible :end_time, :name, :start_time, :is_active

  def toggle_survey(survey)
    survey.toggle!(:is_active)
  end
end
