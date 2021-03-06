class FriendshipsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @friendships = Friendship.where(['creator_id = ? or receiver_id = ?', current_user,
                                     current_user]).where(status: false)
  end

  def create
    @friendship = Friendship.new(creator_id: current_user.id)
    @friendship.receiver_id = params[:receiver_id]
    @friendship.status = false

    @inverse_friendship = Friendship.new(receiver_id: current_user.id)
    @inverse_friendship.creator_id = params[:receiver_id]
    @inverse_friendship.status = false

    if @friendship.save && @inverse_friendship.save
      flash[:notice] = 'Invite created successfully'
    else
      flash[:alert] = 'Invite is not created, try again'
    end
    redirect_to users_path
  end

  def update
    @friendship = Friendship.where(creator_id: params[:creator_id], receiver_id: current_user, status: false)
    @friendship2 = Friendship.where(creator_id: current_user, receiver_id: params[:creator_id], status: false)
    if @friendship.update(status: true) && @friendship2.update(status: true)
      flash[:notice] = 'Friendship accepted'
    else
      flash[:alert] = 'Friendship rejected'
    end
    redirect_to friendships_path
  end

  def destroy
    @friendship = Friendship.find(params[:friendship_id])
    @next = (params[:friendship_id].to_i + 1)
    @friendship2 = Friendship.find(@next)

    if @friendship.destroy && @friendship2.destroy
      flash[:notice] = 'Friend request rejected'
    else
      flash[:alert] = 'Oops there is a problem'
    end
    redirect_to friendships_path
  end
end
