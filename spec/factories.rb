FactoryGirl.define do
  factory :knocker do
    sequence(:first_name)  { |n| "First #{n}" }
    sequence(:last_name)  { |n| "Last #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:identity) { |n| "person_#{n}"}
    birthday				"11/02/1986"
    gender 					"male"
    password 				"password"
    password_confirmation 	"password"
    postcode                "CM22 6EH"
  end

  factory :hype do
    content "Lorem ipsum"
    knocker
  end
end