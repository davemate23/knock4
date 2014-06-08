require 'spec_helper'
include Warden::Test::Helpers
Warden.test_mode!

describe FavouriteknockersController do

  knocker = FactoryGirl.create(:knocker) 
  other_knocker = FactoryGirl.create(:knocker)

  login_as(knocker, :scope => :knocker)

  describe "adding a Favourite Knocker with Ajax" do

    it "should increment the Favourite Knocker count" do
      expect do
        xhr :post, :create, favouriteknocker: { favourite_id: other_knocker.id }
      end.to change(Favouriteknocker, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, favouriteknocker: { favourite_id: other_knocker.id }
      expect(response).to be_success
    end
  end

  describe "destroying a Favourite Knocker relationship with Ajax" do

    before { knocker.favourite!(other_knocker) }
    let(:favouriteknocker) do
      knocker.favouriteknockers.find_by(favourite_id: other_knocker.id)
    end

    it "should decrement the Favourite Knocker count" do
      expect do
        xhr :delete, :destroy, id: favouriteknocker.id
      end.to change(Favouriteknocker, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: favouriteknocker.id
      expect(response).to be_success
    end
  end
end
Warden.test_reset!