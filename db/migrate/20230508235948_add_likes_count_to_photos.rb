class AddLikesCountToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :likes_count, :integer, default: 0, null: false
  end
end
