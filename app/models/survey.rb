class Survey < ActiveRecord::Base
  belongs_to      :course
  has_many        :polls
  attr_accessible :end_time, :name, :start_time, :is_active, :polls_attributes
  accepts_nested_attributes_for :polls, allow_destroy: true

  def toggle_survey(survey)
    survey.toggle!(:is_active)
  end
end
