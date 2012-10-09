class AddPollIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :poll_id, :integer
  end
end
