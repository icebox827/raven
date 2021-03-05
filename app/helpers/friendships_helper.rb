module FriendshipsHelper
  def confirm_friend(user)
    @friendship = current_user.friendships_received.find { |friendship| friendship.user == user }
    @friendship.status = true
    @friendship.save
  end
end
