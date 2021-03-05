module FriendshipsHelper
  def confirm_friend
    @friendship = current_user.friends.find { |friendship| friendship.user == user }
    @friendship.status = true
    @friendship.save
  end
end
