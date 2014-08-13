class Availability < ActiveRecord::Base
	# Fairly straight forward; each Knocker has their own availability.  Every day they list as available is registered in a table alongside their knocker_id.
	belongs_to :knocker

	validates :date, presence: true
	validates :knocker_id, presence: true
end
