class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.new(friendship_params)
    @friendship.confirmed = false
    if current_user.id != @friendship.friend_id && @friendship.save!
      redirect_to users_path, notice: 'Friend request has been sent.'
    else
      redirect_to users_path, notice: 'An error occured. Please try again.'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @friendship = find_friendship(@user)
    if current_user.friend?(@user)
      flash[:notice] = 'Removed friend.'
      @friendship[:user_friend].first.destroy
      @friendship[:inverse_friend].first.destroy
    else
      flash[:notice] = 'Removed friend request.'
      @friendship[:user_friend].first.destroy
    end
    redirect_back(fallback_location: friendships_path)
  end

  def index; end

  def update
    @requestor = User.find(params[:id])
    current_user.confirm_friend(@requestor)
    redirect_back(fallback_location: friendships_path)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:friend_id, :user_id)
  end

  def find_friendship(user)
    friendship_one = Friendship.where(user_id: current_user.id, friend_id: user.id)
    friendship_two = Friendship.where(user_id: user.id, friend_id: current_user.id)
    friendships = { user_friend: friendship_one, inverse_friend: friendship_two }
    friendships
  end
end
