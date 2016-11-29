class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :gravatar_url
end
