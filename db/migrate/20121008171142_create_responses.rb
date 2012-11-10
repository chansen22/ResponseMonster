class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :choiceId
      t.string :short_answer
      t.boolean :is_right
      t.integer :assessment_id
      t.integer :points

      t.timestamps
    end
  end
end
