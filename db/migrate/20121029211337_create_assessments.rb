class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :score
      t.boolean :is_graded, default: false
      t.integer :times_submitted
      t.integer :user_id
      t.integer :survey_id

      t.timestamps
    end
  end
end
