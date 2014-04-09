class Hype < ActiveRecord::Base
	before_create :set_latlong

	belongs_to :knocker

	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :knocker_id, presence: true

	def set_latlong
		self.latitude = knocker.latitude
		self.longitude = knocker.longitude
	end
end
