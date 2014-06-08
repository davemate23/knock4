class EventAttendance < ActiveRecord::Base
	belongs_to :knocker
	belongs_to :event
	validates :knocker_id, presence: true
	validates :event_id, presence: true
end
