class Friendship < ApplicationRecord
  validates :creator, presence: true
  validates :receiver, presence: true

  belongs_to :creator, class_name: :User
  belongs_to :receiver, class_name: :User
end
