class UsersController < ApplicationController
  def index
    @users = User.all
    @friendship = current_user.friendships.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = current_user.friendships.new
  end

  def new_guest
      user = User.find_by(email:"user1@gmail.com")
      if user
          sign_in user
      end
      redirect_to root_path
  end
  def new_admin_guest
      user = User.find_by(email: "chablatech@gmail.com")
      if user
          sign_in user
      end
      redirect_to root_path
  end
end
