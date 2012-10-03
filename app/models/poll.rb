class Poll < ActiveRecord::Base
  belongs_to      :survey
  has_many        :answers, dependent: :destroy
  attr_accessible :question_text, :answer_type, :answers_attributes
  accepts_nested_attributes_for :answers, 
                                reject_if: lambda { |answer| answer[:answer_text].blank? },
                                allow_destroy: true
end
