class GroupEvent < ActiveRecord::Base
	belongs_to :group
	belongs_to :event
	validates :group_id, presence: true
	validates :events_id, presence: true
end
