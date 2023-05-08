# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  comments_count                 :integer
#  email                          :string
#  likes_count                    :integer
#  own_photos_count               :integer
#  password_digest                :string
#  private                        :boolean
#  received_follow_requests_count :integer
#  sent_follow_requests_count     :integer
#  username                       :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
class User < ApplicationRecord
  validates :username, { :presence => true }
  validates :username, { :uniqueness => true }
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  # Direct Associations

  has_many :photos, { :class_name => "Photos", :foreign_key => "owner_id", :dependent => :destroy }

  has_many(:likes, { :class_name => "Like", :foreign_key => "fan_id", :dependent => :destroy })

  has_many(:comments, { :class_name => "Comment", :foreign_key => "commenter_id", :dependent => :destroy })

  has_many(:sent_follow_requests, { :class_name => "FollowRequest", :foreign_key => "sender_id", :dependent => :destroy })

  has_many(:received_follow_requests, { :class_name => "FollowRequest", :foreign_key => "recipient_id", :dependent => :destroy })

  has_many(:own_photos, { :class_name => "Photo", :foreign_key => "owner_id", :dependent => :destroy })

  # Indirect Associations
  has_many(:following, { :through => :sent_follow_requests, :source => :recipient })

  has_many(:followers, { :through => :received_follow_requests, :source => :sender })

  has_many(:liked_photos, { :through => :likes, :source => :photo })

  has_many(:feed, { :through => :following, :source => :own_photos })

  has_many(:activity, { :through => :following, :source => :liked_photos })
end

public

def follow_request_for(other_user_id)
  FollowRequest.where({ sender_id: self.id, recipient_id: other_user_id }).at(0)
  end
