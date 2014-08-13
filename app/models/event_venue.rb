class EventVenue < ActiveRecord::Base
	# Join for Events and Venues.  Requires its own model due to additional table columns:
	# Status column allows for a variable integer of whether or not it is accepted (eg 1 could mean created by Event but not accepted by Venue, 2 could mean created by Venue but not accepted by Event and 0 could mean accepted both ends or something to that effect)
	# Description column allows one of the entities (whichever is required, or an additional column could be added) to describe how they are associated.
	belongs_to :event
	belongs_to :venue
	validates :event_id, presence: true
	validates :venue_id, presence: true
end
