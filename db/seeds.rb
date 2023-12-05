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
Message.destroy_all
Chatroom.destroy_all
User.destroy_all

# Journeys data
PACKING = [["underwear", "passport", "skis", "banana"], ["mug", "panda", "jetski"], ["shoes", "jeans", "shirt"]]

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

puts 'Creating users xox'

user_details.each do |details|
  user = User.create!(details)

  puts "User #{user.id}: #{user.username} created"
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

howlon = Journey.create!(user: howard, location: "London", category: "Art and Culture", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

howber = Journey.create!(user: howard, location: "Berlin", category: "Art and Culture", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

howbah = Journey.create!(user: howard, location: "Bahamas", category: "Art and Culture", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

saylon = Journey.create!(user: sayyab, location: "London", category: "Nightife", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

sayber = Journey.create!(user: sayyab, location: "Berlin", category: "Nightife", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

saybah = Journey.create!(user: sayyab, location: "Bahamas", category: "Nightife", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

marlon = Journey.create!(user: marco, location: "London", category: "Road Trip", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

marber = Journey.create!(user: marco, location: "Berlin", category: "Road Trip", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

marbah = Journey.create!(user: marco, location: "Bahamas", category: "Road Trip", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

tonlon = Journey.create!(user: tony, location: "London", category: "City Break", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

tonber = Journey.create!(user: tony, location: "Berlin", category: "City Break", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

tonbah = Journey.create!(user: tony, location: "Bahamas", category: "City Break", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

jodlon = Journey.create!(user: jodie, location: "London", category: "Camping", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

jodber = Journey.create!(user: jodie, location: "Berlin", category: "Camping", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

jodbah = Journey.create!(user: jodie, location: "Bahamas", category: "Camping", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

heilon = Journey.create!(user: heidi, location: "London", category: "City Break", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

heiber = Journey.create!(user: heidi, location: "Berlin", category: "City Break", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

heibah = Journey.create!(user: heidi, location: "Bahamas", category: "City Break", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

willon = Journey.create!(user: will, location: "London", category: "Nightlife", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

wilber = Journey.create!(user: will, location: "Berlin", category: "Nightlife", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

wilbah = Journey.create!(user: will, location: "Bahamas", category: "Nightlife", start_date: "30/11/2023", end_date: "03/12/2023", packing_list: PACKING.sample)

puts "creating experiences for each journey"

Experience.create!(journey: howlon, title: "Natural History Museum", content: "If the dinosaurs were so great how come they all died out...", address: "Natural History Museum, London", category: "Art and Culture")
Experience.last.liked_by(will, vote_weight: 138)
Experience.last.photos.attach(io: URI.open('https://www.mumwhatelse.com/wp-content/uploads/2016/12/natural-history-museum2-1-1440x960.jpg'), filename: "nes.png", content_type: "image/png")

Experience.create!(journey: howber, title: "The Wall Museum", content: "Seeing an important piece of German history was very interesting.", address: "The Wall Museum, Berlin", category: "Art and Culture")
Experience.last.photos.attach(io: URI.open('https://www.bordersofadventure.com/wp-content/uploads/2020/05/Checkpoint-Charlie-Black-Box-Berlin-Museum.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 204)

Experience.create!(journey: howbah, title: "Queen's Staircase", content: "Love me an old staircase!", address: "Queen's Staircase, Nassau", category: "Art and Culture")
Experience.last.photos.attach(io: URI.open('https://www.nassauparadiseisland.com/sites/default/files/styles/portrait/public/images/2023-05/Queens_Staircase_362989708_0.jpeg?h=790be497&itok=cZd1GFJR'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 382)

Experience.create!(journey: saylon, title: "fabric London", content: "Great club that plays drum and bass, dubstep, house and techno.", address: "fabric London, London", category: "Nightlife")
Experience.last.photos.attach(io: URI.open('https://thewestreviewdotcom.files.wordpress.com/2014/12/fabric-london-2.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 163)

Experience.create!(journey: sayber, title: "Bar Becketts Kopf", content: "Can't remember too much from that night because the cocktails were so good!", address: "Bar Becketts Kopf, Berlin", category: "Nightlife")
Experience.last.photos.attach(io: URI.open('https://assets-prd.punchdrink.com/wp-content/uploads/2019/04/Thumb-Decibel-Japanese-Sake-Bar-East-Village-NYC.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 74)

Experience.create!(journey: saybah, title: "Nippers Beach Bar & Grill", content: "Nothing better than a drink at the beach with live music!", address: "Nippers Beach Bar & Grill, Great Guana Cay", category: "Nightlife")
Experience.last.photos.attach(io: URI.open('https://image.yachtcharterfleet.com/w1920/h619/qh/ca/kd49382ea/directory/profile/photo/973103.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 26)

Experience.create!(journey: marlon, title: "Hoxton Mediterranean Cafe", content: "Great food at a decent price!", address: "Hoxton Mediterranean Cafe, London", category: "Food")
Experience.last.photos.attach(io: URI.open('https://lh3.googleusercontent.com/p/AF1QipOg0ObALSYbfV1yJEKMuH-t7O5XhjCISsqZVASs=s1360-w1360-h1020'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 496)

Experience.create!(journey: marber, title: "McDonald's", content: "Thank goodness there is a McDonald's here!", address: "McDonald's, 10623 Berlin", category: "Food")
Experience.last.photos.attach(io: URI.open('https://lh3.googleusercontent.com/p/AF1QipO8CWEgXfp5JCqDchiZ5BMCqW-Bzd1LSHLwTA9u=s1360-w1360-h1020'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 688)

Experience.create!(journey: marbah, title: "Cafe Madeleine", content: "I thought I would try and lose a bit of weight this holiday...", address: "Cafe Madeleine, Bahamas", category: "Food")
Experience.last.photos.attach(io: URI.open('https://media-cdn.tripadvisor.com/media/photo-s/11/29/d3/32/food-display.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 317)

Experience.create!(journey: tonlon, title: "London Eye", content: "It's not as big in real life as in the pictures...", address: "lastminute.com London Eye, London", category: "Other")
Experience.last.photos.attach(io: URI.open('https://upload.wikimedia.org/wikipedia/commons/b/b4/London_Eye_Twilight_April_2006.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 148)

Experience.create!(journey: tonber, title: "Reichstag Building", content: "Why did the UK leave the EU :(", address: "Reichstag Building, Berlin", category: "Other")
Experience.last.photos.attach(io: URI.open('https://berlintraveltips.com/wp-content/uploads/2023/10/Berlin-Reichstag-Building-free-tour-glass-dome.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 225)

Experience.create!(journey: tonbah, title: "Ardastra Gardens & Wildlife Conservation Centre", content: "Flamingos are real???!!!", address: "Ardastra Gardens & Wildlife Conservation Centre, Nassau", category: "Other")
Experience.last.photos.attach(io: URI.open('https://dynamic-media-cdn.tripadvisor.com/media/photo-o/05/5c/d8/80/ardastra-gardens-zoo.jpg?w=1200&h=-1&s=1'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 703)

Experience.create!(journey: jodlon, title: "Harry Potter and the Cursed Child", content: "Great play but needed more Harry!", address: "Palace Theatre, London", category: "Art and Culture")
Experience.last.photos.attach(io: URI.open('https://strangenessandcharm.co.uk/wp-content/uploads/2019/08/85C4392D-FF8D-4D10-92EC-C48F89AD62EC.jpeg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 461)

Experience.create!(journey: jodber, title: "Berlin 3-Course Dinner Cruise", content: "Strongly recommend to people that love Berlin, dinners and cruises.", address: "Rosengarten, Berlin", category: "Other")
Experience.last.photos.attach(io: URI.open('https://media-cdn.tripadvisor.com/media/attractions-splice-spp-720x480/0b/19/f3/8f.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 178)

Experience.create!(journey: jodbah, title: "Aquaventure", content: "Why did they put fish under the slides??!!", address: "Aquaventure, Paradise Island", category: "Other")
Experience.last.photos.attach(io: URI.open('https://dynamic-media-cdn.tripadvisor.com/media/photo-o/08/22/91/f5/aquaventure-water-park.jpg?w=1200&h=1200&s=1'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 392)

Experience.create!(journey: heilon, title: "Historic Pub Walking Tour", content: "Great tour but the beer wasn't free 😢.", address: "Tower Bridge Pier, London", category: "Art and Culture")
Experience.last.photos.attach(io: URI.open('https://media.tacdn.com/media/attractions-splice-spp-674x446/07/aa/43/f9.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 108)

Experience.create!(journey: heiber, title: "CHAMÄLEON Theater", content: "Hold my beer", address: "CHAMÄLEON Theater, Berlin", category: "Nightlife")
Experience.last.photos.attach(io: URI.open('https://lh3.googleusercontent.com/p/AF1QipOIjDn6FUjcDPXleA25wdIulEV-3nEQmYvmTzlS=s1360-w1360-h1020'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 77)

Experience.create!(journey: heibah, title: "Crabs and Ting", content: "I love crab! 🦀🦀🦀", address: "Crabs and Ting, Nassau", category: "Food")
Experience.last.photos.attach(io: URI.open('https://media-cdn.tripadvisor.com/media/photo-m/1280/13/ee/d3/47/menu.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 351)

Experience.create!(journey: willon, title: "Pret A Manger", content: "Why are there so many of these in London??!! I can't escape!", address: "161 City Road, London", category: "Food")
Experience.last.photos.attach(io: URI.open('https://lh3.googleusercontent.com/p/AF1QipNoT-IJEqIykETFFgJ0OVue4LmBe2jstltRZnxZ=s1360-w1360-h1020'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 773)

Experience.create!(journey: wilber, title: "Charlottenburg Palace", content: "I wonder how much this would cost to buy?", address: "Charlottenburg Palace, Berlin", category: "Art and Culture")
Experience.last.photos.attach(io: URI.open('https://res.cloudinary.com/hello-tickets/image/upload/c_limit,f_auto,q_auto,w_768/v1613580604/post_images/berlin-158/palacio-charlottenburg/32119144363_182d6aaca4_o_Cropped.jpg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 846)

Experience.create!(journey: wilbah, title: "Pink Sands Beach", content: "This beach reminds me of the pink KitKat.", address: "Pink Sands Beach, Bahamas", category: "Other")
Experience.last.photos.attach(io: URI.open('https://www.travelmanagers.com.au/wp-content/uploads/2023/08/AdobeStock_64327804-scaled.jpeg'), filename: "nes.png", content_type: "image/png")
Experience.last.liked_by(will, vote_weight: 728)

puts "seeding complete"

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
