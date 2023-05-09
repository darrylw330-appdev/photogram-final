# == Schema Information
#
# Table name: follow_requests
#
#  id           :integer          not null, primary key
#  status       :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class FollowRequest < ApplicationRecord
  # Validations
  validates(:sender_id, { :presence => true })
  validates(:recipient_id, { :presence => true })
  validates(:recipient_id, { :uniqueness => { :scope => ["sender_id"], :message => "already requested" } })

  # Direct Associations
  belongs_to(:sender, { :required => true, :class_name => "User", :foreign_key => "sender_id", :counter_cache => :sent_follow_requests_count })
  belongs_to(:recipient, { :required => true, :class_name => "User", :foreign_key => "recipient_id", :counter_cache => :received_follow_requests_count })

  # has_many :following_photos, { :through => :recipient, :source => :photos }

  def following_photos
    following_user = User.where({ :id => self.recipient_id }).at(0)
    photos = Photo.where({ :owner_id => following_user.id })

    photos
  end
end
