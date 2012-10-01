class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.string :answer_type
      t.string :question

      t.timestamps
    end
  end
end
