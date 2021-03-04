class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    users = [current_user.id]
    unless Friendship.find_by(creator_id: current_user.id).nil?
      users << Friendship.find_by(creator_id: current_user.id).receiver_id
    end
    unless Friendship.find_by(receiver_id: current_user.id).nil?
      users << Friendship.find_by(receiver_id: current_user.id).creator_id
    end
    @users = User.where('id NOT IN (?)', users)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
