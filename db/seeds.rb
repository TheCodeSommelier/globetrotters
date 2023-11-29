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

DATE = Date.current
LOCATIONS = ["London", "New York", "Tokyo", "Sydney"]
CATEGORIES = ["Skiing", "Camping", "Diving", "Road Trip"]
LANGUAGES = ["German", "Cantonese", "Spanish", "English"]
CURRENCY = ["EUR", "GBP", "USD", "YEN"]
TZDATA = TZInfo::Timezone.all_identifiers
PACKING = ["underwear, passport, skis, banana", "mug, panda, jetski", "shoes, jeans, shirt"]
EXPERIENCE_TITLES = ["Three grey hounds pub", "Ski slope jetski", "London eye"]
CATEGORIES_EXPERIENCE = ["Food", "Nightlife", "Art and Culture", "Other"]

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

experience_details = [
  {
    title: EXPERIENCE_TITLES.sample,
    content: "Wooow what an experience!!",
    address: "Hoxton, London",
    category: CATEGORIES_EXPERIENCE.sample
  }
]

puts 'Creating users xox'

user_details.each do |details|
  user = User.create!(details)

  puts "User #{user.id}: #{user.username} created"

  puts "✈️-✈️-✈️-✈️ Creating Journeys For #{user.username} ✈️-✈️-✈️-✈️"

  journey_details.each do |journery_details|
    journey = Journey.new(journery_details)
    journey.user = user
    journey.location = LOCATIONS.sample
    # journey.time_zone = TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{journey.location}") }).to_local(Time.new)
    journey.save

    puts "Created Journeys For #{user.username}"

    experience_details.each do |experience_detail|
      experience = Experience.new(experience_detail)
      experience.journey = journey
      experience.likes = rand(100..1000)
      experience.save
    end
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
