class GroupVenue < ActiveRecord::Base
	belongs_to :group
	belongs_to :venue
	validates :group_id, presence: true
	validates :venue_id, presence: true
end
