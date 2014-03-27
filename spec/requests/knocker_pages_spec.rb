require 'spec_helper'

describe "Knocker Pages" do
	subject { page }
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
        fill_in "Date of birth",          with: "01/01/1989"
        fill_in "Postcode",               with: "CM22 6EH"
      end

      it "should create a knocker" do
        expect { click_button submit}.to change(Knocker, :count).by(1)
      end
    end
  end
end
