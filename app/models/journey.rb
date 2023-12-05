class Journey < ApplicationRecord
  attr_accessor :packing_item

  belongs_to :user

  has_many :experiences, dependent: :destroy
  has_many :saved_experiences, dependent: :destroy

  # Before seeding comment from line out till line 25 and once the seed is done put this back in
  after_create :prebuild_sightseeing_list

  def packing_list
    @packing_list ||= super.blank? ? set_packing_list : super
  end

  private

  def set_packing_list
    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      "messages": [
        { "role": "system", "content": "Packing assistant" },
        { "role": "user", "content": "I am going to #{location}, on the #{start_date} and coming back on #{end_date}. Help me write a packing a list. Separate each packing item with a comma and a space and write only the packing items, do not write any pleasantries or extra information. Also write all of the items as a single string do not categorise." }
      ],
      "model": "gpt-3.5-turbo"
    })
    new_packing_list = chaptgpt_response["choices"][0]["message"]["content"].split(", ")
    update(packing_list: new_packing_list)
    @packing_list = new_packing_list
  end

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
