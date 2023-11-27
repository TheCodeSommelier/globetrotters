class Experience < ApplicationRecord
  belongs_to :journey

  has_many :saved_experiences, dependent: :destroy

  # Only if we want to show how many times has an experince been saved inside of a journeys
  # has_many :journeys, through: :saved_experiences, dependent: :destroy
end
