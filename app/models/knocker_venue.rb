class KnockerVenue < ActiveRecord::Base
	belongs_to :knocker
	belongs_to :venue
	validates :knocker_id, presence: true
	validates :venue_id, presence: true

end
