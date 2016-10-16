class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :commenting_users, through: :comments, source: :user
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  mount_uploader :photo, PhotoUploader

  validate :photo_size

  private

  def photo_size
    if photo.size > 5.megabytes
      errors.add(:photo, "Image should be less than 5MB")
    end
  end
end
