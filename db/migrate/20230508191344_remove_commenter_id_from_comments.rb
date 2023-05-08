class RemoveCommenterIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :commenter_id
  end
end
