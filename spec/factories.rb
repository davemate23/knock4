FactoryGirl.define do
  factory :knocker do
    sequence(:first_name)  { |n| "Person #{n}" }
    sequence(:last_name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:username) { |n| "person_#{n}"}
    birthday				"11/02/1986"
    gender 					"male"
    password 				"password"
    password_confirmation 	"password"
    postcode                "CM22 6EH"
  end
end