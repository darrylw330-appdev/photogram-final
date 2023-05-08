class RemoveUserIdFromPhotos < ActiveRecord::Migration[6.0]
  def change
    remove_column :photos, :user_id
  end
end
