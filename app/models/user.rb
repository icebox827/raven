class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, dependent: :destroy, foreign_key: :creator_id
  has_many :inverse_friendships, -> { where status: false }, class_name: :Friendships, foreign_key: :receiver_id
  has_many :friend_requests, through: :inverse_friendships

  has_many :confirmed_friendships, -> { where status: true }, class_name: :Friendships
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: :Friendships, foreign_key: :creator_id
  has_many :pending_friends, through: :pending_friendships, source: :friend

  def friends_and_own_posts
    Post.where(user: (friends.to_a << self))
  end
end
