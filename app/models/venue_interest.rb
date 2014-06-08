class VenueInterest < ActiveRecord::Base
	belongs_to :interest
	belongs_to :venue
	validates :interest_id, presence: true
	validates :venue_id, presence: true
end
