class Survey < ActiveRecord::Base
  belongs_to      :course
  attr_accessible :end_time, :name, :start_time, :is_active

  validates( :name, presence:true )
end
