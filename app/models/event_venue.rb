class EventVenue < ActiveRecord::Base
	belongs_to :event
	belongs_to :venue
	validates :event_id, presence: true
	validates :venue_id, presence: true
end
