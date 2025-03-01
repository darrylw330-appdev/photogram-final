# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :string
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  location       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  # Validations
  validates(:owner_id, { :presence => true })
  validates(:image, { :presence => true })

  mount_uploader :image, ImageUploader

  # Direct Associations
  belongs_to(:owner, { :required => true, :class_name => "User", :foreign_key => "owner_id", :counter_cache => :own_photos_count })

  has_many(:likes, { :class_name => "Like", :foreign_key => "photo_id", :dependent => :destroy })

  has_many(:comments, { :class_name => "Comment", :foreign_key => "photo_id", :dependent => :destroy })

  # Indirect Associations
  has_many(:fans, { :through => :likes, :source => :user })

  has_many(:followers, { :through => :owner, :source => :following })

  has_many(:fan_followers, { :through => :fans, :source => :following })

  scope :pub, -> { joins(:owner).where(users: { private: false }) }
  # def self.pub
  #   joins(:owner).where(users: { private: false })
  # end
end

