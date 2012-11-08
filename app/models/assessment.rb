class Assessment < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :responses, dependent: :destroy

  def self.create_assessment(user, times_submitted, survey)
    assessment = user.assessments.build
    assessment.user = user
    assessment.survey = survey
    assessment.times_submitted = times_submitted
    assessment
  end

  def self.remove_old_assessment(assessment)
    if assessment
      delete(assessment)
    end
  end

  def self.grade(assessment)
    needs_more_grading = false
    assessment.responses.each do |response|
      if response.choiceId.nil?
        needs_more_grading = true
      else
        answer = response.poll.answers.where(id: response.choiceId).first
        if answer.is_right
          response.is_right = true
        else
          response.is_right = false
        end
        response.save
      end
    end

    assessment.is_graded = !needs_more_grading
    assessment.save
  end

  def self.taken(assessment, old_assessment)
    if old_assessment
      assessment.times_submitted = old_assessment.times_submitted + 1
    else
      assessment.times_submitted = 1
    end
  end
end
