require 'spec_helper'

describe "StaticPages" do
  subject {page}

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home Page" do
    before { visit root_path }
    let(:heading)     { 'Knock4' }
    let(:page_title)  { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    describe "for signed-in knockers" do
      let(:knocker) { FactoryGirl.create(:knocker) }
      before do
        FactoryGirl.create(:hype, knocker: knocker, content: "Lorem Ipsum", latitude: 51.410457, longitude: -0.833861)
        FactoryGirl.create(:hype, knocker: knocker, content: "Dolor Sit Amet", latitude: 51.410457, longitude: -0.833861)
        sign_in knocker
        visit root_path
      end

      it "should render the knocker's feed" do
        knocker.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help Page" do
    before { visit help_path } 

    let(:heading)     { 'Help' }
    let(:page_title)  { 'Help' }

    it_should_behave_like "all static pages"
  end

  describe "About Page" do
    before { visit about_path }

    let(:heading)     { 'About Knock4' }
    let(:page_title)  { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Contact Page" do
    before {visit contact_path}

    let(:heading)     { 'Contact Us' }
    let(:page_title)  { 'Contact' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign Up'))
  end
end
