module FriendshipsHelper
  def confirm_a_request(user)
    @friendship = current_user.receiver.find { |friendship| friendship.user == user }
    @friendship.status = true
    @friendship.save
  end
end
