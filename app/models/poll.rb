class Poll < ActiveRecord::Base
  belongs_to      :survey
  attr_accessible :question_text, :answer_type
end
