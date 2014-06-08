require 'spec_helper'

describe "HypePages" do

	subject { page }

	knocker = FactoryGirl.create(:knocker) 
	login_as(knocker, :scope => :knocker)

	describe "hype creation" do
		before { visit root_path }

		describe "with invalid information" do

			it "should not create a hype" do
				expect { click_button "Post" }.not_to change(Hype, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do

			before { fill_in 'hype_content', with: "Lorem ipsum" }
			it "should create a hype" do
				expect { click_button "Post" }.to change(Hype, :count).by(1)
			end
		end
	end

	describe "hype destruction" do
		before { FactoryGirl.create(:hype, knocker: knocker) }

		describe "as correct knocker" do
			before { visit root_path }

			it "should delete a hype" do
				expect { click_link "delete" }.to change(Hype, :count).by(-1)
			end
		end
	end
end
