FactoryGirl.define do
  factory :knocker do
    first_name 				"Michael"
    last_name  				"Hartl"
    username 				"michaelhartl"
    dob 					"11/02/1986"
    gender 					"male"
    email    				"michael@example.com"
    password 				"password"
    password_confirmation 	"password"
    postcode                "CM22 6EH"
  end
end