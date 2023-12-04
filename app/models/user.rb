class User < ApplicationRecord
  has_many :journeys
  has_one_attached :photo
  has_many :experiences, through: :journeys
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  acts_as_voter

  include PgSearch::Model
  pg_search_scope :search_by_username,
    against: [ :username ],
    using: {
      tsearch: { prefix: true }
    }
end
