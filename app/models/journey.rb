class Journey < ApplicationRecord
  belongs_to :user

  has_many :experiences, dependent: :destroy
  has_many :saved_experiences, dependent: :destroy

  # Before seeding comment from line out till line 25 and once the seed is done put this back in
  after_create :prebuild_sightseeing_list

  private

  def prebuild_sightseeing_list
    location = self.location
    # Use with geocoder
    # experience.address.near(self.location)
    experience_in_location = Experience.all.select do |experience|
      experience.journey.location == location
    end

    experiences_top_most_liked = experience_in_location.sort_by(&:cached_weighted_average).reverse.first(5)

    experiences_top_most_liked.each { |experience| SavedExperience.create!(experience: experience, journey: self) }
  end
end
