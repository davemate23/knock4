class EventAttendance < ActiveRecord::Base
	# Basic join model of Events and Knockers.  Requires its own model due to the additional admin column.
	belongs_to :knocker
	belongs_to :event
	validates :knocker_id, presence: true
	validates :event_id, presence: true
end
