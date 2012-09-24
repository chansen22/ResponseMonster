class AddCourseIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :course_id, :integer
  end
end
