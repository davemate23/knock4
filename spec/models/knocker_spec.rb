require 'spec_helper'

describe Knocker do

	before { @knocker = Knocker.new(first_name: "Example", last_name: "Knocker", username: "knock4", email: "knocker@knock4.com", password: "password", birthday: "1985-04-23", gender: "male", postcode: "RG40 4QJ", latitude: "0.07", longitude: "8.99") }

	subject { @knocker }

	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:username) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:gender) }
	it { should respond_to(:birthday) }
	it { should respond_to(:postcode) }

	it { should be_valid }

	describe "when first_name is not present" do
		before { @knocker.first_name = " " }
		it { should_not be_valid }
	end

	describe "when last_name is not present" do
		before { @knocker.last_name = " " }
		it { should_not be_valid }
	end

	describe "when username is not present" do
		before { @knocker.username = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @knocker.email = " " }
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @knocker.password = " " }
		it { should_not be_valid }
	end

	describe "when dob is not present" do
		before { @knocker.birthday = " " }
		it { should_not be_valid }
	end

	describe "when postcode is not present" do
		before { @knocker.postcode = " " }
		it { should_not be_valid }
	end

	describe "when gender is not present" do
		before { @knocker.gender = " " }
		it { should_not be_valid }
	end

	describe "when first_name is too long" do
    	before { @knocker.first_name = "a" * 26 }
    	it { should_not be_valid }
  	end

  	describe "when last_name is too long" do
    	before { @knocker.last_name = "a" * 26 }
    	it { should_not be_valid }
  	end

  	describe "when username is too long" do
    	before { @knocker.username = "a" * 21 }
    	it { should_not be_valid }
  	end

  	describe "when username format is invalid" do
    	it "should be invalid" do
      		usernames = %w[knocker@foo,com user_@@at_foo.org example.%user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      		usernames.each do |invalid_username|
       			@knocker.username = invalid_username
        		expect(@knocker).not_to be_valid
      		end
    	end
  	end

  	describe "when username format is valid" do
    	it "should be valid" do
      		usernames = %w[userfoo.COM A_US-ERf.b.org frst.lst-foo.jp a-bbaz.cn]
      		usernames.each do |valid_username|
        		@knocker.username = valid_username
        		expect(@knocker).to be_valid
      		end
    	end
  	end

  	describe "when username is already taken" do
    	before do
      		knocker_with_same_username = @knocker.dup
      		knocker_with_same_username.username = @knocker.username.upcase
      		knocker_with_same_username.save
    	end

    	it { should_not be_valid }
  	end
end
