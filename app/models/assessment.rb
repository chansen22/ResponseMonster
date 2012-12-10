class Assessment < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :responses, dependent: :destroy
  attr_accessible :responses_attributes
  accepts_nested_attributes_for :responses, allow_destroy: true

  def grade
    if survey.total_points.nil?
      return self.save
    end
    self.score = 0
    # for each survey question
    self.survey.polls.each do |poll|
      # get number correct needed
      if poll.is_radio == "Yes"
        correct_needed = 1
      else
        correct_needed = Answer.where(poll_id: poll, is_right: true).length
      end
      num_correct = 0
      # Get responses for question
      to_grade = self.responses.where(poll_id: poll)
      to_grade.each do |r|
        # check if response->answer is correct
        if !Answer.where(id: r.choiceId, is_right: true).empty?
          r.is_right = true
          r.save
          num_correct += 1
        else
          r.is_right = false
          r.save
        end
      end
      if num_correct == correct_needed
        self.score += poll.points
      end
    end
    self.save
  end
end
