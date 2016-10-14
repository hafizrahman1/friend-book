class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :commenting_users, through: :comments, source: :user
  has_many :likes
end
