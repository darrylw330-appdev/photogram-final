class AddStatusToFollowRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :follow_requests, :status, :string
  end
end
