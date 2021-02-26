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
  has_many :inverse_friendships, dependent: :destroy, class_name: :Friendships, foreign_key: :receiver_id

  def send_f_request
    @friendship = current_user.friendships.build(frienship_params)
    @friendship.status = false

    if @friendship.save
      flash[:notice] = 'Frienship created successfully'
      redirect_to friendship_path
    else
      flash[:alert] = 'Friendship is not created, try again'
      render 'new'
    end
  end

  def accept_f_request
    @friendship = Friendship.find_by(:receiver_id :current_user).find_by(frienship_params_2)
    @friendship.status = :true
    @friendship.update
  end

  private

  def friendship_params
    params.require(:friendship).permit(:receiver_id)
  end

  def friendship_params_2
    params.require(:friendship).permit(:creator_id)
  end
end
