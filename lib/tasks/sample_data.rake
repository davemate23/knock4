namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_knockers
    make_hypes
    make_favouriteknockers
  end
end

def make_knockers
    admin = Knocker.create!(first_name: "Example",
                 last_name: "Knocker",
                 identity: "newknocker",
                 email: "example@knock4.com",
                 password: "password",
                 password_confirmation: "password",
                 birthday: "01/01/1990",
                 gender: "Female",
                 postcode: "CM22 6EH")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      Knocker.create!(first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   identity: Faker::Internet.user_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   birthday: Faker::Business.credit_card_expiry_date,
                   gender: "Female",
                   postcode: Faker::Address.postcode,
                   town: Faker::Address.city,
                   latitude: Faker::Address.latitude,
                   longitude: Faker::Address.longitude,
                   nationality: Faker::Address.country,
                   country: Faker::Address.country)
    end
end
   
def make_hypes 
    knockers = Knocker.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      knockers.each { |knocker| knocker.hypes.create!(content: content) }
    end
end

def make_favouriteknockers
  knockers = Knocker.all
  knocker = knockers.first
  favourite_knockers = knockers[2..50]
  favourited_knockers = knockers[3..40]
  favourite_knockers.each { |favourite| knocker.favourite!(favourite) }
  favourited_knockers.each { |favourited| favourited.favourite!(knocker) }  
end