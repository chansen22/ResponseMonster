class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :answer_type
      t.string :is_radio
      t.string :question_text
      t.integer :points

      t.timestamps
    end
  end
end
