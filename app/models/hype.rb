class Hype < ActiveRecord::Base
	before_create :set_latlong

	belongs_to :author, polymorphic: true
	has_many :interests

	default_scope -> { order('created_at DESC') }
	validates :content, presence: true, length: { maximum: 140 }
	validates :author_id, presence: true
	validates :author_type, presence: true

	def set_latlong
		self.latitude = author.latitude
		self.longitude = author.longitude
	end

	def self.from_knockers_favourited_by(knocker)
		favourited_knocker_ids = "SELECT favourite_id FROM favouriteknockers
									WHERE favourited_id = :knocker_id"
		where("author_id IN (#{favourited_knocker_ids}) OR author_id = :knocker_id", knocker_id: knocker.id)
	end
end
