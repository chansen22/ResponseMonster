class Poll < ActiveRecord::Base
  belongs_to      :survey
  has_many        :answers
  attr_accessible :question_text, :answer_type
  accepts_nested_attributes_for :answers, allow_destroy: true
end
