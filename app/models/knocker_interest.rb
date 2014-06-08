class KnockerInterest < ActiveRecord::Base
	belongs_to :knocker
	belongs_to :interest
	validates :knocker_id, presence: true
	validates :interest_id, presence: true
end
