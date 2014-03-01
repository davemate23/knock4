require 'spec_helper'

describe "StaticPages" do
  let(:base_title) { "Knock4" }
  describe "Home Page" do
    it "should have the content 'Knock4'" do
      visit '/static_pages/home'
      expect(page).to have_content('Knock4')
    end

    it "should have the base title" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Knock4")
    end

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

     it "should have the title 'Help'" do
    	visit '/static_pages/help'
    	expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About Page" do
    it "should have the content 'About Knock4'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Knock4')
    end

    it "should have the title 'About'" do
    	visit '/static_pages/about'
    	expect(page).to have_title("#{base_title} | About")
    end
  end

  describe "Contact Page" do
      it "should have the content 'Contact Us'" do
        visit '/static_pages/contact'
        expect(page).to have_content('Contact Us')
      end

      it "should have the title 'Contact'" do
        visit '/static_pages/contact'
        expect(page).to have_title("#{base_title} | Contact")
      end
  end
end
