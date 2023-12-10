class User < ApplicationRecord
  has_many :journeys
  has_one_attached :photo
  has_many :experiences, through: :journeys
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :chatrooms
  validates :username, :email, :password, :first_name, :last_name, :bio, presence: true
  validates :bio, length: { maximum: 100 }
  validates :username, uniqueness: true
  validates :password, form: {
    with: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/
  }
  validates :email, uniqueness: true

  acts_as_voter

  include PgSearch::Model
  pg_search_scope :search_by_username,
    against: [ :username ],
    using: {
      tsearch: { prefix: true }
    }
  has_many :chatrooms_as_user_1, class_name: "chatroom", foreign_key: :user_1
  has_many :chatrooms_as_user_2, class_name: "chatroom", foreign_key: :user_2

end
