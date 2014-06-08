class GroupMember < ActiveRecord::Base
	belongs_to :knocker
	belongs_to :group
	validates :knocker_id, presence: true
	validates :group_id, presence: true
end
