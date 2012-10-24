class Survey < ActiveRecord::Base
  belongs_to      :course
  has_many        :polls, dependent: :destroy
  attr_accessible :end_time, :name, :start_time, :is_active, :polls_attributes, :attempts_allowed
  accepts_nested_attributes_for :polls, 
                                reject_if: lambda { |question| question[:question_text].blank? },
                                allow_destroy: true

  def toggle_survey(survey)
    survey.toggle!(:is_active)
  end
end
