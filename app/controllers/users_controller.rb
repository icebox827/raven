class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    #@users = User.joins('INNER JOIN friendships ON users.id=creator_id').where('friendships.creator_id != users.id or friendships.receiver_id != users.id')
    # @attendees = User.joins('INNER JOIN invitations ON users.user_id=invitations.attendee').where('invitations.attended_event' => @event.id)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
