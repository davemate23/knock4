class Hype < ActiveRecord::Base
	# Hype is like a status, where you can write about things you're up to, or advertise to people locally what you want to do.  Hopefully we can also integrate id tags into them as mentions.  They will display (dependent on user settings) in the newsfeeds of knockers within a certain radius of the source.
	before_create :set_latlong

	belongs_to :author, polymorphic: true
	has_many :interests

	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :author_id, presence: true
	validates :author_type, presence: true

	def set_latlong
		# Uses the author's lat and long to give the hype a location for local feeds.
		self.latitude = author.latitude
		self.longitude = author.longitude
	end

	def self.from_knockers_favourited_by(knocker)
		favourited_knocker_ids = "SELECT favourite_id FROM favouriteknockers
									WHERE favourited_id = :knocker_id"
		where("author_id IN (#{favourited_knocker_ids}) OR author_id = :knocker_id", knocker_id: knocker.id)
	end
end
