class Survey < ActiveRecord::Base
  belongs_to      :course
  has_many        :polls, dependent: :destroy
  has_many        :assessments, dependent: :destroy
  has_many        :users, through: :assessments
  attr_accessible :end_time, 
                        :name, 
                        :start_time, 
                        :is_active, 
                        :polls_attributes, 
                        :attempts_allowed,
                        :total_points,
                        :password

  validates(:name, presence: true)

  accepts_nested_attributes_for :polls, 
                                reject_if: lambda { |question| question[:question_text].blank? },
                                allow_destroy: true

  def toggle_survey(survey)
    survey.toggle!(:is_active)
  end
end
