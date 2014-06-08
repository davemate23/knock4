require 'spec_helper'

describe Knocker do

	before do
		@knocker = Knocker.new(first_name: "Example", last_name: "Knocker", identity: "knock4", email: "knocker@knock4.com", password: "password", birthday: "1985-04-23", gender: "male", postcode: "RG40 4QJ", latitude: "0.07", longitude: "8.99")
	end

	subject { @knocker }

	it { should respond_to(:first_name) }
	it { should respond_to(:last_name) }
	it { should respond_to(:identity) }
	it { should respond_to(:email) }
	it { should respond_to(:password) }
	it { should respond_to(:gender) }
	it { should respond_to(:birthday) }
	it { should respond_to(:postcode) }
	it { should respond_to(:hypes) }
  it { should respond_to(:feed) }
  it { should respond_to(:favouriteknockers) }
  it { should respond_to(:favourite_knockers) }
  it { should respond_to(:reverse_favouriteknockers) }
  it { should respond_to(:favourited_knockers) }
  it { should respond_to(:favourited?) }
  it { should respond_to(:favourite!) }
  it { should respond_to(:unfavourite!) }



	it { should be_valid }

  describe "when first_name is not present" do
		before { @knocker.first_name = " " }
		it { should_not be_valid }
	end

	describe "when last_name is not present" do
		before { @knocker.last_name = " " }
		it { should_not be_valid }
	end

	describe "when identity is not present" do
		before { @knocker.identity = " " }
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

  	describe "when identity is too long" do
    	before { @knocker.identity = "a" * 21 }
    	it { should_not be_valid }
  	end

  	describe "when identity format is invalid" do
    	it "should be invalid" do
      		identities = %w[knocker@foo,com user_@@at_foo.org example.%user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      		identities.each do |invalid_identity|
       			@knocker.identity = invalid_identity
        		expect(@knocker).not_to be_valid
      		end
    	end
  	end

  	describe "when identity format is valid" do
    	it "should be valid" do
      		identities = %w[userfoo.COM A_US-ERf.b.org frst.lst-foo.jp a-bbaz.cn]
      		identities.each do |valid_identity|
        		@knocker.identity = valid_identity
        		expect(@knocker).to be_valid
      		end
    	end
  	end

  	describe "when identity is already taken" do
    	before do
      		knocker_with_same_identity = @knocker.dup
      		knocker_with_same_identity.identity = @knocker.identity.upcase
      		knocker_with_same_identity.save
    	end

    	it { should_not be_valid }
  	end

  	describe "hype associations" do

    before { @knocker.save }
    let!(:older_hype) do
      FactoryGirl.create(:hype, knocker: @knocker, created_at: 1.day.ago)
    end
    let!(:newer_hype) do
      FactoryGirl.create(:hype, knocker: @knocker, created_at: 1.hour.ago)
    end

    it "should have the right hypes in the right order" do
      expect(@knocker.hypes.to_a).to eq [newer_hype, older_hype]
    end

    it "should destroy associated hypes" do
    	hypes = @knocker.hypes.to_a
    	@knocker.destroy
    	expect(hypes).not_to be_empty
    	hypes.each do |hype|
    		expect(Hype.where(id: hype.id)).to be_empty
    	end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:hype, knocker: FactoryGirl.create(:knocker))
      end
      let(:favourited_knocker) { FactoryGirl.create(:knocker) }

      before do
        @knocker.favourite!(favourited_knocker)
        3.times { favourited_knocker.hypes.create!(content: "Lorem ipsum") }
      end

      its(:feed) { should include(newer_hype) }
      its(:feed) { should include(older_hype) }
      its(:feed) { should_not include(unfollowed_post) }
      its(:feed) do
        favourited_knocker.hypes.each do |hype|
          should include(hype)
        end
      end
    end
  end

  describe "favourited" do
    let(:other_knocker) { FactoryGirl.create(:knocker) }
    before do
      @knocker.save
      @knocker.favourite!(other_knocker)
    end

    it { should be_favourited(other_knocker) }
    its(:favourite_knockers) { should include(other_knocker) }

    describe "and unfavourited" do
      before { @knocker.unfavourite!(other_knocker) }

      it { should_not be_favourited(other_knocker) }
      its(:favourite_knockers) { should_not include(other_knocker) }
    end 

    it { should be_favourited(other_knocker) }
    its(:favourite_knockers) { should include(other_knocker) }

    describe "favourite knocker" do
      subject { other_knocker }
      its(:favourited_knockers) { should include(@knocker) }
    end 
  end

end
