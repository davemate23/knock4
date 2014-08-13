class GroupVenue < ActiveRecord::Base
	#Basic join model between groups and venues.  See Event_Venues for more info, however this should also have a description column (probably one of the more important ones for it)
	belongs_to :group
	belongs_to :venue
	validates :group_id, presence: true
	validates :venue_id, presence: true
end
