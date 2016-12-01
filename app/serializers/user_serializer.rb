class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :gravatar_url
  has_many :comments, serializer: CommentSerializer
end
