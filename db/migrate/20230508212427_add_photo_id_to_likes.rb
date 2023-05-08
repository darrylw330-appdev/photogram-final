class AddPhotoIdToLikes < ActiveRecord::Migration[6.0]
  def change
    add_reference :likes, :photo, foreign_key: true
  end
end
