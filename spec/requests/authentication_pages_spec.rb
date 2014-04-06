require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:knocker) }
      before do
        fill_in "Email",    with: knocker.email.upcase
        fill_in "Password", with: knocker.password
        click_button "Sign in"
      end

      it { should have_title(knocker.name) }
      it { should have_link('Knockers',    href: knocker_index_path) }
      it { should have_link('Profile',     href: knocker_path(knocker)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
  
      describe "in the Users controller" do
      
        describe "visiting the knocker index" do
          before { visit knocker_path }
          it { should have_title('Sign in') }
        end
      end
    end
  end
end