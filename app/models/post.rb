class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags
  
  scope :all_posts, ->(current_user) { (where(user: current_user) + where(user: current_user.friends)).sort_by(&:created_at).reverse}
  mount_uploader :photo, PhotoUploader
  
  validates_presence_of :content
  validate :photo_size

  def tags_attributes=(tags_attributes)
    tags_attributes.values.each do |tag_attribute|
      if tag_attribute[:name].present?
        self.tags.build(tag_attribute)
      end
    end
  end
 

  private

  def photo_size
    if photo.size > 3.megabytes
      errors.add(:photo, "Image should be less than 3MB")
    end
  end
end
