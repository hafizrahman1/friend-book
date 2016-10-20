class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  validates_presence_of :user_id, :friend_id
  
  # scope :friend_exists?, ->(user, friend) { (where(user_id: user.id).where(friend_id: friend.id)).nil? }

  def self.exists?(user, friend)
    !find_by_user_id_and_friend_id(user, friend).nil?
  end

  def self.request(user, friend)
    # user and friend are not same and friendship does not exist
    unless user == friend or Friendship.exists?(user, friend)
      # as a requester the status is pending(pending_friends)
      Friendship.create(user: user, friend: friend, status: 'pending')
      # as an accepter the status is requested(requested_friends)
      Friendship.create(user: friend, friend: user, status: 'requested')
    end
  end

  def self.accept(user, friend)
    # accept as a requester
    Friendship.accept_half(user, friend)
    # accept as an accepter
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
