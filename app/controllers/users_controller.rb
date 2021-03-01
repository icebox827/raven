class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    #@fri = Friendship.select(:receiver_id).where("creator_id = ?", current_user)
    #@fri2 = Friendship.select(:creator_id).where("receiver_id = ?", current_user)
    #@users = User.where("id != ?", current_user).where("id NOT IN", Friendship.select(creator_id).where(:receiver_id current_user))
    # @attendees = User.joins('INNER JOIN invitations ON users.user_id=invitations.attendee').where('invitations.attended_event' => @event.id)
    #@users = User.where("id != ?", current_user)
    #@users.each do |user|
      #@future_friends = user.id unless Friendship.where(:creator_id current_user, :receiver_id user.id).or(:creator_id user.id, :receiver_id current_user)
    #end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
