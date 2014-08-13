class KnockerVenue < ActiveRecord::Base
	# Basic join model for knockers and venues, includes admin column.
	belongs_to :knocker
	belongs_to :venue
	validates :knocker_id, presence: true
	validates :venue_id, presence: true

end
