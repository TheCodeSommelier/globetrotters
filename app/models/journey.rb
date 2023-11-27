class Journey < ApplicationRecord
  belongs_to :user

  has_many :experiences, dependent: :destroy
  has_many :saved_experiences, dependent: :destroy
  has_many :experiences, through: :saved_experiences, dependent: :destroy
end
