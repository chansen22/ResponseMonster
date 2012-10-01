class AddSurveyIdToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :survey_id, :integer
  end
end
