class FriendshipsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    # @friendship = Friendship.new
    @friendships = Friendship.where(receiver_id: current_user).where(status: false)
    @inverse_friendships = Friendship.where(creator_id: current_user).where(status: false)
  end

  def create
    # @friendship = Friendship.new
    # @friendship.creator_id = current_user
    @friendship = Friendship.new(creator_id: current_user.id)
    @friendship.receiver_id = params[:receiver_id]
    @friendship.status = false

    if @friendship.save
      flash[:notice] = 'Invite created successfully'
    else
      flash[:alert] = 'Invite is not created, try again'
    end
    redirect_to users_path
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

  def destroy
    @friendship = Friendship.find(params[:friendship_id])

    if @friendship.destroy
      flash[:notice] = 'Friend request rejected'
    else
      flash[:alert] = 'Oops there is a problem'
    end
    redirect_to friendships_path
  end
end
