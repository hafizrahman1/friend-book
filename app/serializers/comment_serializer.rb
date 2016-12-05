class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user, :post
  # has_one :user, serializer: CommentUserSerializer
  # belongs_to :user
end
