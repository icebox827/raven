class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    # List to all users
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
