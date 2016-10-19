module FriendshipsHelper
  def friend_request?
    !current_user.requested_friends.empty?
  end
end
