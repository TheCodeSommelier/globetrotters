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
# DATE = Date.current
# LOCATIONS = ["London", "New York", "Berlin", "Prague"]
# CATEGORIES = ["Skiing", "Camping", "Diving", "Road Trip"]
# LANGUAGES = ["German", "Cantonese", "Spanish", "English"]
# CURRENCY = ["EUR", "GBP", "USD", "YEN"]
# TZDATA = TZInfo::Timezone.all_identifiers
# PACKING = ["underwear, passport, skis, banana", "mug, panda, jetski", "shoes, jeans, shirt"]
# IMAGE_URLS = [
#   "https://escales.ponant.com/wp-content/uploads/2020/12/plage.jpg",
#   "https://hips.hearstapps.com/hmg-prod/images/lake-bled-in-slovenia-royalty-free-image-1644922973.jpg",
#   "https://upload.wikimedia.org/wikipedia/commons/b/b6/Mount_Everest_as_seen_from_Drukair2_PLW_edit_Cropped.jpg"
# ]

# # Experience data
# CATEGORIES_EXPERIENCE = ["Food", "Nightlife", "Art and Culture", "Other"]
# EXPERIENCE_TITLES = [
#   ["Three grey hounds pub", "Nice botanical garden", "London eye"],
#   ["That ribs place", "Nomad burger", "John's milkshakes"],
#   ["Bier mit wurst pub", "Konig Honig pub", "Berlin TV Tower"],
#   ["Prague Castle", "The Mist", "Sweet share cafe"],
#   ["Prague Castle", "The Mist", "Sweet share cafe"],
#   ["Prague Castle", "The Mist", "Sweet share cafe"],
#   ["Prague Castle", "The Mist", "Sweet share cafe"]
# ]
# EXPERIENCE_ADDRESSES = [
#   ["Hoxton, London", "Kingston, London", "Shoreditch, London"],
#   ["Manhattan, New York", "Queens, New York", "Brooklyn, New York"],
#   ["Mitte, Berlin", "Kreuzberg, Berlin", "Pankow, Berlin"],
#   ["Namesti Republiky, Prague", "Smichov, Prague", "Karlin, Prague"]
# ]

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
  },
  {
    email: 'jodie@gmail.com',
    password: '123456',
    first_name: "Jodie",
    last_name: "Bloggs",
    username: "jodieB"
  },
  {
    email: 'heidi@gmail.com',
    password: '123456',
    first_name: "Heidi",
    last_name: "Smith",
    username: "heidiS"
  },
  {
    email: 'will@gmail.com',
    password: '123456',
    first_name: "Will",
    last_name: "Smith",
    username: "willS"
  }
]

# journey_details = [
#   {
#     # user_id: User.find(tony),
#     category: CATEGORIES.sample,
#     language: LANGUAGES.sample,
#     currency: CURRENCY.sample,
#     time_zone: TZInfo::Timezone.get("Asia/Tokyo").to_local(Time.new),
#     start_date: DATE,
#     end_date: DATE + 5,
#     packing_list: PACKING.sample
#     # time_zone: TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{location}") }).to_local(Time.new)
#     # time_zone: TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{location}") }).to_local(Time.new)
#   }
# ]

puts 'Creating users xox'

user_details.each do |details|
  user = User.create!(details)

  puts "User #{user.id}: #{user.username} created"

  # puts "✈️-✈️-✈️-✈️ Creating Journeys For #{user.username} ✈️-✈️-✈️-✈️"

  # journey_details.each do |journey_detail|
  #   journey = Journey.new(journey_detail)
  #   journey.user = user
  #   journey.location = LOCATIONS.shift
  #   # journey.time_zone = TZInfo::Timezone.get(TZDATA.select { |timezone| timezone.include?("#{journey.location}") }).to_local(Time.new)
  #   journey.save

  #   puts "Created Journeys For #{user.username}"

  #   addresses_for_experience = EXPERIENCE_ADDRESSES.shift
  #   titles_for_experience = EXPERIENCE_TITLES.shift

  #   puts "Creating Experiences for #{user.username}!"

  #   3.times do
  #     experience = Experience.new(
  #       {
  #         title: titles_for_experience.sample,
  #         content: "Wooow what an experience!!",
  #         category: CATEGORIES_EXPERIENCE.sample
  #       }
  #     )

  #     experience.photos.attach(io: URI.open(IMAGE_URLS.sample), filename: "nes.png", content_type: "image/png")
  #     experience.journey = journey
  #     experience.address = addresses_for_experience.shift
  #     experience.likes = rand(100..1000)
  #     experience.save
  #   end
  #   puts "Experiences Created! for #{user.username}"
  # end
end

puts "adding photos for each user"

howard = User.find_by first_name: 'Howard'
howard.photo.attach(io: URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1696525592/dqr0ahzvj9g5wizu8b9s.jpg'), filename: "nes.png", content_type: "image/png")

sayyab = User.find_by first_name: 'Sayyab'
sayyab.photo.attach(io: URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1699401643/mxduyziruoju4bzzyf6q.jpg'), filename: "nes.png", content_type: "image/png")

tony = User.find_by first_name: 'Tony'
tony.photo.attach(io: URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1696533138/wbxcseqnb5qddi8z3qex.jpg'), filename: "nes.png", content_type: "image/png")

marco = User.find_by first_name: 'Marco'
marco.photo.attach(io: URI.open('https://avatars.githubusercontent.com/u/146257070?v=4'), filename: "nes.png", content_type: "image/png")

jodie = User.find_by first_name: 'Jodie'
jodie.photo.attach(io: URI.open('https://t4.ftcdn.net/jpg/04/44/53/99/360_F_444539901_2GSnvmTX14LELJ6edPudUsarbcytOEgj.jpg'), filename: "nes.png", content_type: "image/png")

heidi = User.find_by first_name: 'Heidi'
heidi.photo.attach(io: URI.open('https://images.pexels.com/photos/3763188/pexels-photo-3763188.jpeg?cs=srgb&dl=pexels-andrea-piacquadio-3763188.jpg&fm=jpg'), filename: "nes.png", content_type: "image/png")

will = User.find_by first_name: 'Will'
will.photo.attach(io: URI.open('https://media.wired.com/photos/5d960eba01e4a4000826137c/master/pass/Culture_Monitor_WillSmith-465783654.jpg'), filename: "nes.png", content_type: "image/png")

puts "creating journeys for each user"

howlon = Journey.create!(user: howard, location: "London", category: "Art and Culture", start_date: "09/12/2023", end_date: "14/12/2023")

howber = Journey.create!(user: howard, location: "Berlin", category: "Art and Culture", start_date: "09/12/2023", end_date: "14/12/2023")

howbah = Journey.create!(user: howard, location: "Bahamas", category: "Art and Culture", start_date: "09/12/2023", end_date: "14/12/2023")

saylon = Journey.create!(user: sayyab, location: "London", category: "Nightife", start_date: "09/12/2023", end_date: "14/12/2023")

sayber = Journey.create!(user: sayyab, location: "Berlin", category: "Nightife", start_date: "09/12/2023", end_date: "14/12/2023")

saybah = Journey.create!(user: sayyab, location: "Bahamas", category: "Nightife", start_date: "09/12/2023", end_date: "14/12/2023")

marlon = Journey.create!(user: marco, location: "London", category: "Road Trip", start_date: "09/12/2023", end_date: "14/12/2023")

marber = Journey.create!(user: marco, location: "Berlin", category: "Road Trip", start_date: "09/12/2023", end_date: "14/12/2023")

marbah = Journey.create!(user: marco, location: "Bahamas", category: "Road Trip", start_date: "09/12/2023", end_date: "14/12/2023")

tonlon = Journey.create!(user: tony, location: "London", category: "City Break", start_date: "09/12/2023", end_date: "14/12/2023")

tonber = Journey.create!(user: tony, location: "Berlin", category: "City Break", start_date: "09/12/2023", end_date: "14/12/2023")

tonbah = Journey.create!(user: tony, location: "Bahamas", category: "City Break", start_date: "09/12/2023", end_date: "14/12/2023")

jodlon = Journey.create!(user: jodie, location: "London", category: "Camping", start_date: "09/12/2023", end_date: "14/12/2023")

jodber = Journey.create!(user: jodie, location: "Berlin", category: "Camping", start_date: "09/12/2023", end_date: "14/12/2023")

jodbah = Journey.create!(user: jodie, location: "Bahamas", category: "Camping", start_date: "09/12/2023", end_date: "14/12/2023")

heilon = Journey.create!(user: heidi, location: "London", category: "City Break", start_date: "09/12/2023", end_date: "14/12/2023")

heiber = Journey.create!(user: heidi, location: "Berlin", category: "City Break", start_date: "09/12/2023", end_date: "14/12/2023")

heibah = Journey.create!(user: heidi, location: "Bahamas", category: "City Break", start_date: "09/12/2023", end_date: "14/12/2023")

willon = Journey.create!(user: will, location: "London", category: "Nightlife", start_date: "09/12/2023", end_date: "14/12/2023")

wilber = Journey.create!(user: will, location: "Berlin", category: "Nightlife", start_date: "09/12/2023", end_date: "14/12/2023")

wilbah = Journey.create!(user: will, location: "Bahamas", category: "Nightlife", start_date: "09/12/2023", end_date: "14/12/2023")

# Experience.create!(journey: )


# def save_experience_to_join_table
#   Journey.all.each do |journey|
#     experience_in_location = Experience.all.select do |experience|
#       experience.journey.location == journey.location
#     end

#     experiences_top_most_liked = experience_in_location.sort_by(&:likes).reverse.first(5)

#     experiences_top_most_liked.each { |experience| SavedExperience.create!(experience: experience, journey: journey) }
#   end
# end

# save_experience_to_join_table
