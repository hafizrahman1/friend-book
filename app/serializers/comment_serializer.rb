class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user
  # has_one :user, serializer: CommentUserSerializer
  # belongs_to :user
end
