namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Knocker.create!(first_name: "Example",
                 last_name: "Knocker",
                 username: "newknocker",
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
                   username: Faker::Internet.user_name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   birthday: Faker::Business.credit_card_expiry_date,
                   gender: "Female",
                   postcode: Faker::Address.postcode,
                   town: Faker::Address.city,
                   latitude: Faker::Address.latitude,
                   longitude: Faker::Address.longitude,
                   nationality: Faker::Address.country)
    end
  end
end