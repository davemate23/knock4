require 'spec_helper'

describe "Knocker Pages" do
	subject { page }
  
  describe "index" do
    before do
      sign_in FactoryGirl.create(:knocker)
      FactoryGirl.create(:knocker, first_name: "Bob", last_name: "Hosken", postcode: "CM22 6EH", username: "bobbyboy", birthday: "05/20/1984", gender: "Male", password: "blogblog", password_confirmation: "blogblog", email: "bob@example.com")
      FactoryGirl.create(:knocker, first_name: "Ben", last_name: "Hope", postcode: "RG40 4QJ", username: "bennybay", birthday: "05/20/1984", gender: "Male", password: "blogblog", password_confirmation: "blogblog", email: "ben@example.com")
      visit knocker_path
    end

    it { should have_title('All knockers') }
    it { should have_content('All knockers') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:knocker) } }
      after(:all)  { Knocker.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each knocker" do
        Knocker.paginate(page: 1).each do |knocker|
          expect(page).to have_selector('li', text: knocker.name)
        end
      end
    end

    it "should list each knocker" do
      Knocker.all.each do |knocker|
        expect(page).to have_selector('li', text: knocker.name)
      end
    end
  end
  describe "signup page" do
   	before { visit signup_path }
   	it { should have_content('Sign Up') }
   	it { should have_title(full_title('Sign Up')) }
  end

  describe "profile page" do
    let(:knocker) { FactoryGirl.create(:knocker) }
    before { visit knocker_path(knocker) }

    it { should have_content(knocker.name) }
    it { should have_title(knocker.name) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Create my account!"}

    describe "with invalid information" do
      it "should not create a knocker" do
        expect { click_button submit }.not_to change(Knocker, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First name",             with: "Example"
        fill_in "Last name",              with: "Knocker"
        fill_in "Username",               with: "exampleuser"
        fill_in "Email",                  with: "knocker@example.com"
        fill_in "Password",               with: "password"
        fill_in "Password confirmation",  with: "password"
        fill_in "Gender",                 with: "Female"
        fill_in "Birthday",               with: "01/01/1989"
        fill_in "Postcode",               with: "CM22 6EH"
      end

      it "should create a knocker" do
        expect { click_button submit}.to change(Knocker, :count).by(1)
      end
    end
  end
end
