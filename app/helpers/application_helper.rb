module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def my_friends
    requested_friends = current_user.friendships.map(&:receiver)
    accepted_friends = current_user.friendships.map(&:creator)
    requested_friends.compact + accepted_friends.compact
  end

  def friend?(_user)
    requested_friends = current_user.friendships.map { |friendship| friendship.receiver if friendship.status == false }
    accepted_friends = current_user.friendships.map { |friendship| friendship.creator if friendship.status == true }
    requested_friends.compact + accepted_friends.compact
  end

  def row_creator(user)
    f1 = Friendship.find_by(creator_id: user.creator_id, receiver_id: user.receiver_id)
    f2 = Friendship.find_by(creator_id: user.receiver_id, receiver_id: user.creator_id)

    f1.id < f2.id
  end
end
