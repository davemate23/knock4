class GroupMember < ActiveRecord::Base
	# Basic join model between knockers and groups.  Has two additional columns (state and admin).
	# State shows the affiliation a user has with the group (eg 1 could be invited, 2 could be pending acceptance, 3 could be requested invitation, etc), admin is whether or not the user is an admin (and potentially levels too... eg owner, admin, etc).
	belongs_to :knocker
	belongs_to :group
	validates :knocker_id, presence: true
	validates :group_id, presence: true
end
