class KnockerInterest < ActiveRecord::Base
	# Basic model for join between Knockers and Interests, to cater for additional columns.
	# Ability column allows a rating of ability (1 could mean beginner, 2 intermediate, 3 advanced, 4 professional, 5 would like to try, etc), using integers could allow different wording for different activities.
	# Third Party column says whether or not the user likes to take part or act as a third party (watching football, rather than playing for example)
	# Teach column gives the option to say whether the user has any coaching ability... this could easily be expanded to various levels, qualifications too.
	
	belongs_to :knocker
	belongs_to :interest
	validates :knocker_id, presence: true
	validates :interest_id, presence: true
end
