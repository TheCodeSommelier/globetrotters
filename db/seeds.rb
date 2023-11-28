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

LOCATIONS = ["London", "New York", "Tokyo", "Sydney"]
CATEGORIES = ["Skiing", "Camping", "Diving", "Road Trip"]
LANGUAGES = ["German", "Cantonese", "Spanish", "English"]
CURRENCY = ["EUR", "GBP", "USD", "YEN"]
TZDATA = TZInfo::Timezone.all_identifiers

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
    location: LOCATIONS.sample,
    category: CATEGORIES.sample,
    language: LANGUAGES.sample,
    currency: CURRENCY.sample,
    time_zone: TZInfo::Timezone.get("Asia/Tokyo").to_local(Time.new)
    # time_zone: TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{location}") }).to_local(Time.new)
    # time_zone: TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{location}") }).to_local(Time.new)
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
    # journey.time_zone = TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{journey.location}") }).to_local(Time.new)
    journey.save

    puts "Created Journeys For #{user.username}"
  end
end
