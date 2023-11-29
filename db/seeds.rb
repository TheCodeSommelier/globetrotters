# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'tzinfo'

puts 'Cleaning DB 🧼'
SavedExperience.destroy_all
Experience.destroy_all
Journey.destroy_all
User.destroy_all

# Journeys data
DATE = Date.current
LOCATIONS = ["London", "New York", "Berlin", "Prague"]
CATEGORIES = ["Skiing", "Camping", "Diving", "Road Trip"]
LANGUAGES = ["German", "Cantonese", "Spanish", "English"]
CURRENCY = ["EUR", "GBP", "USD", "YEN"]
TZDATA = TZInfo::Timezone.all_identifiers
PACKING = ["underwear, passport, skis, banana", "mug, panda, jetski", "shoes, jeans, shirt"]
IMAGE_URLS = [
  "https://escales.ponant.com/wp-content/uploads/2020/12/plage.jpg",
  "https://hips.hearstapps.com/hmg-prod/images/lake-bled-in-slovenia-royalty-free-image-1644922973.jpg",
  "https://upload.wikimedia.org/wikipedia/commons/b/b6/Mount_Everest_as_seen_from_Drukair2_PLW_edit_Cropped.jpg"
]

# Experience data
CATEGORIES_EXPERIENCE = ["Food", "Nightlife", "Art and Culture", "Other"]
EXPERIENCE_TITLES = [
  ["Three grey hounds pub", "Nice botanical garden", "London eye"],
  ["That ribs place", "Nomad burger", "John's milkshakes"],
  ["Bier mit wurst pub", "Konig Honig pub", "Berlin TV Tower"],
  ["Prague Castle", "The Mist", "Sweet share cafe"]
]
EXPERIENCE_ADDRESSES = [
  ["Hoxton, London", "Kingston, London", "Shoreditch, London"],
  ["Manhattan, New York", "Queens, New York", "Brooklyn, New York"],
  ["Mitte, Berlin", "Kreuzberg, Berlin", "Pankow, Berlin"],
  ["Namesti Republiky, Prague", "Smichov, Prague", "Karlin, Prague"]
]

# User data
user_details = [
  {
    email: 'sayyab@gmail.com',
    password: "123456",
    first_name: "Sayyab",
    last_name: "Khan",
    username: "s777yab"
  },
  {
    email: 'tony@gmail.com',
    password: "123456",
    first_name: "Tony",
    last_name: "Masek",
    username: "tonyM"
  },
  {
    email: 'marco@gmail.com',
    password: "123456",
    first_name: "Marco",
    last_name: "Di Leo",
    username: "marcoDL"
  },
  {
    email: 'howard@gmail.com',
    password: '123456',
    first_name: "Howard",
    last_name: "Thompson",
    username: "howardT"
  }
]

journey_details = [
  {
    # user_id: User.find(tony),
    category: CATEGORIES.sample,
    language: LANGUAGES.sample,
    currency: CURRENCY.sample,
    time_zone: TZInfo::Timezone.get("Asia/Tokyo").to_local(Time.new),
    start_date: DATE,
    end_date: DATE + 5,
    packing_list: PACKING.sample
    # time_zone: TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{location}") }).to_local(Time.new)
    # time_zone: TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{location}") }).to_local(Time.new)
  }
]

puts 'Creating users xox'

user_details.each do |details|
  user = User.create!(details)

  puts "User #{user.id}: #{user.username} created"

  puts "✈️-✈️-✈️-✈️ Creating Journeys For #{user.username} ✈️-✈️-✈️-✈️"

  journey_details.each do |journey_detail|
    journey = Journey.new(journey_detail)
    journey.user = user
    journey.location = LOCATIONS.shift
    # journey.time_zone = TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{journey.location}") }).to_local(Time.new)
    journey.save

    puts "Created Journeys For #{user.username}"

    addresses_for_experience = EXPERIENCE_ADDRESSES.shift
    titles_for_experience = EXPERIENCE_TITLES.shift

    puts "Creating Experiences for #{user.username}!"

    3.times do
      experience = Experience.new(
        {
          title: titles_for_experience.sample,
          content: "Wooow what an experience!!",
          category: CATEGORIES_EXPERIENCE.sample
        }
      )

      experience.photos.attach(io: URI.open(IMAGE_URLS.sample), filename: "nes.png", content_type: "image/png")
      experience.journey = journey
      experience.address = addresses_for_experience.shift
      experience.likes = rand(100..1000)
      experience.save
    end
    puts "Experiences Created! for #{user.username}"
  end
end

def save_experience_to_join_table
  Journey.all.each do |journey|
    experience_in_location = Experience.all.select do |experience|
      experience.journey.location == journey.location
    end

    experiences_top_most_liked = experience_in_location.sort_by(&:likes).reverse.first(5)

    experiences_top_most_liked.each { |experience| SavedExperience.create!(experience: experience, journey: journey) }
  end
end

save_experience_to_join_table
