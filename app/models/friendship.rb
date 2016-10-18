class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  validates_presence_of :user_id, :friend_id

  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(user, friend)
    unless user == friend or Friendship.exists?(user, friend)
      Friendship.create(user: user, friend: friend, status: 'pending')
      Friendship.create(user: friend, friend: user, status: 'requested')
    end
  end

  def self.accept(user, friend)
    Friendship.accept_half(user, friend)
    Friendship.accept_half(friend, user)
  end

  def self.breakup(user, friend)
    destroy(find_by_user_id_and_friend_id(user, friend))
    destroy(find_by_user_id_and_friend_id(friend, user))
  end

  private

  def self.accept_half(user, friend)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.save
  end

end
