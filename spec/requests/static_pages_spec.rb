require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the content 'Knock4'" do
      visit '/static_pages/home'
      expect(page).to have_content('Knock4')
    end

    it "should have the title 'Home'" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Knock4 | Home")
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end

     it "should have the title 'Help'" do
    	visit '/static_pages/help'
    	expect(page).to have_title("Knock4 | Help")
    end
  end

  describe "About Page" do
    it "should have the content 'About Knock4'" do
      visit '/static_pages/about'
      expect(page).to have_content('About Knock4')
    end

     it "should have the title 'About'" do
    	visit '/static_pages/home'
    	expect(page).to have_title("Knock4 | About")
    end
  end
end
