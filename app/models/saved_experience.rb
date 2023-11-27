class SavedExperience < ApplicationRecord
  belongs_to :experience
  belongs_to :journey
end
