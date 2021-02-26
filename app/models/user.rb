class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :frienships, foreign_key: :creator_id
  has_many :inverse_friendships, class_name: :Friendship, foreign_key: :receiver_id

  has_many :confirmed_friendships, -> { where status: true }, class_name: :Friendship
  has_many :friends, through: :confirmed_friendships

  has_many :pending_friendships, -> { where status: false }, class_name: :Friendship, foreign_key: :user_id
  has_many :pending_friends, through: :pending_friendships, source: :friend

  has_many :inverted_friendships, -> { where status: false }, class_name: :Friendship, foreign_key: :friend_id
  has_many :friend_requests, through: :inverted_friendships, source: :user

  # Add method to model for friendship
end
