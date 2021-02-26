class FriendshipsController < ApplicationController
  def index 
    @friendships = Friendship.where(receiver_id: current_user).where(status: false)
  end

  def create
    @friendship = Friendship.new
    @friendship.creator_id = current_user
    @friendship.receiver_id = params[:receiver_id]
    @friendship.status = false

    if @friendship.save
      flash[:notice] = 'Frienship created successfully'
    else
      flash[:alert] = 'Friendship is not created, try again'
    end
    redirect_to friendship_path
  end

  def update
    @friendship.status = true
    if @friendship.update 
      flash[:notice] = 'Friendship accepted'
    else
      flash[:alert] = 'Friendship rejected'
    end
    redirect_to friendship_path
  end
end
