class VenueInterest < ActiveRecord::Base
	# Basic join model for Venue and Interests.  Added description column for more details.
	belongs_to :interest
	belongs_to :venue
	validates :interest_id, presence: true
	validates :venue_id, presence: true
end
