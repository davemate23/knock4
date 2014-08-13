class GroupsInterest < ActiveRecord::Base
	# Basic join model.  Not sure exactly why this can't just be a has and belongs to many relationship, but I think I wanted to include a description column in the table.
	belongs_to :group
	belongs_to :interest
	validates :group_id, presence: true
	validates :interest_id, presence: true
end
