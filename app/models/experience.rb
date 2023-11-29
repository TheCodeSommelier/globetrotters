class Experience < ApplicationRecord
  belongs_to :journey

  has_many :saved_experiences, dependent: :destroy

  has_many_attached :photos


  include PgSearch::Model
  pg_search_scope :search_by_address,
    against: [ :address, :title ],
    using: {
      tsearch: { prefix: true }
      }

  # Only if we want to show how many times has an experince been saved inside of a journeys
  # has_many :journeys, through: :saved_experiences, dependent: :destroy


end
