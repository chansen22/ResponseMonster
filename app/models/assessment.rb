class Assessment < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :responses, dependent: :destroy

  def self.grade(assessment)
    needs_more_grading = false
    assessment.score = 0
    assessment.responses.each do |response|
      if response.choiceId.nil?
        needs_more_grading = true
      else
        answer = response.poll.answers.where(id: response.choiceId).first
        if answer.is_right
          response.is_right = true
          response.points = response.poll.points
        else
          response.is_right = false
          response.points = 0
        end
        response.save
        assessment.score += response.points 
      end
      if !needs_more_grading
        assessment.is_graded = true
      else
        assessment.is_graded = false
      end
      assessment.save
    end

    assessment.is_graded = !needs_more_grading
    assessment.save
  end
end
