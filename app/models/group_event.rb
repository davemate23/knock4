class GroupEvent < ActiveRecord::Base
	# See Event_Venue for similar details
	belongs_to :group
	belongs_to :event
	validates :group_id, presence: true
	validates :events_id, presence: true
end
