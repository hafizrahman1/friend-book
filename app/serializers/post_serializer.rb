class PostSerializer < ActiveModel::Serializer
  attributes :id, :photo, :content, :created_at
  has_one :user
  has_many :comments
  has_many :tags
end
