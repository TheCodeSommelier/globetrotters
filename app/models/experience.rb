class Experience < ApplicationRecord
  belongs_to :journey

  has_many :saved_experiences, dependent: :destroy
  has_many_attached :photos

  validates :address, :title, :content, :category, presence: true, uniqueness: true
  validates :photos, presence: true
  validates :title, length: { maximum: 25 }
  validates :content, length: { maximum: 50 }
  validates :category, inclusion: { in: ["Food", "Nightlife", "Art and Culture", "Other"] }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  acts_as_votable

  include PgSearch::Model
  pg_search_scope :search_by_address,
    against: [ :address, :title ],
    using: {
      tsearch: { prefix: true }
    }
end
