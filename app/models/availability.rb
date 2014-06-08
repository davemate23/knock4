class Availability < ActiveRecord::Base
	belongs_to :knocker

	validates :date, presence: true
	validates :knocker_id, presence: true
end
