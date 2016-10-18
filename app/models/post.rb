class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :commenting_users, through: :comments, source: :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user
  has_many :post_tags
  has_many :tags, through: :post_tags
  mount_uploader :photo, PhotoUploader
  
  validates_presence_of :content
  validate :photo_size

  private

  def photo_size
    if photo.size > 5.megabytes
      errors.add(:photo, "Image should be less than 5MB")
    end
  end
end
