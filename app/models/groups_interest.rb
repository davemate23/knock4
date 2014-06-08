class GroupsInterest < ActiveRecord::Base
	belongs_to :group
	belongs_to :interest
	validates :group_id, presence: true
	validates :interest_id, presence: true
end
