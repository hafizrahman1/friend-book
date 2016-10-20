class FriendshipsController < ApplicationController
  before_action :find_friend, except: :index

  def index
    @friends = current_user.friends
  end

  def create
    Friendship.request(current_user, @friend)
    flash[:notice] = "Friend request send to #{@friend.name}!"
    redirect_to :back 
  end

  def update
    if current_user.requested_friends.include?(@friend)
      Friendship.accept(current_user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} accepted"
    else
      flash[:notice] = "No Friendship request"
    end
    redirect_to :back
  end

  def destroy
    if current_user.friends.include?(@friend)
      Friendship.breakup(current_user, @friend)
      flash[:notice] = "Successfully deleted #{@friend.name}"
    elsif current_user.requested_friends.include?(@friend)
      Friendship.breakup(current_user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} declined"
    elsif current_user.pending_friends.include?(@friend)
      Friendship.breakup(current_user, @friend)
      flash[:notice] = "Friendship request to #{@friend.name} retracted"
    else
      flash[:notice] = "No Friendship request"
    end
    redirect_to :back

  end

  private

  def find_friend
    @friend = User.find(params[:friend_id])
  end

end
