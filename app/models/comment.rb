# == Schema Information
#
# Table name: comments
#
#  id :integer          not null, primary key
#
class Comment < ApplicationRecord
  # Validations
  validates(:photo_id, { :presence => true })
  validates(:body, { :presence => true })

  # Direct Associations
  belongs_to(:commenter, { :required => true, :class_name => "User", :foreign_key => "author_id" })

  belongs_to(:photo, { :required => true, :class_name => "Photo", :foreign_key => "photo_id", :counter_cache => true })
end
