class EventInterest < ActiveRecord::Base
	belongs_to :interest
	belongs_to :event
	validates :event_id, presence: true
	validates :interest_id, presence: true
end
