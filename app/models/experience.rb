class Experience < ApplicationRecord
  belongs_to :journey

  has_many :saved_experiences, dependent: :destroy
  validates :address, presence: true, uniqueness: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  has_many_attached :photos

  acts_as_votable

  include PgSearch::Model
  pg_search_scope :search_by_address,
    against: [ :address, :title ],
    using: {
      tsearch: { prefix: true }
    }
end
