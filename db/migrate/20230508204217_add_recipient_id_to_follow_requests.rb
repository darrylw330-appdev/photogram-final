class AddRecipientIdToFollowRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :follow_requests, :recipient_id, :integer
  end
end
