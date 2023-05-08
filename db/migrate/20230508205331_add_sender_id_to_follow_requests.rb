class AddSenderIdToFollowRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :follow_requests, :sender_id, :integer
  end
end
