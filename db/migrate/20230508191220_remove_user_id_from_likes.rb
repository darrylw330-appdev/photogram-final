class RemoveUserIdFromLikes < ActiveRecord::Migration[6.0]
  def change
    remove_column :likes, :user_id
  end
end
