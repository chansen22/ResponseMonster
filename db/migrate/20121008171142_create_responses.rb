class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :choiceId
      t.string :shortAnswer

      t.timestamps
    end
  end
end
