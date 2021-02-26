class FriendshipsController < ApplicationController
  def index
    @friendship = Friendship.new
    @friendships = Friendship.where(receiver_id: current_user).where(status: false)
  end

  def create
    @friendship = Friendship.new
    @friendship.creator_id = current_user
    @friendship.receiver_id = params[:receiver_id]
    @friendship.status = false

    if @friendship.save
      flash[:notice] = 'Friendship created successfully'
    else
      flash[:alert] = 'Friendship is not created, try again'
    end
    redirect_to friendship_path
  end

  def update
    @friendship = Friendship.where(creator_id: params[:creator_id], receiver_id: current_user, status: false)
    if @friendship.update(status: true)
      flash[:notice] = 'Friendship accepted'
    else
      flash[:alert] = 'Friendship rejected'
    end
    redirect_to friendships_path
  end
end
