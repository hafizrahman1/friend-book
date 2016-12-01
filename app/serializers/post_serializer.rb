class PostSerializer < ActiveModel::Serializer
  attributes :id, :photo, :content, :created_at
  has_one :user, serializer: UserSerializer
  has_many :comments, serializer: CommentSerializer
  has_many :tags
end
