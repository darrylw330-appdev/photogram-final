class AddLikedPhotosToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :liked_photos, :integer
  end
end
