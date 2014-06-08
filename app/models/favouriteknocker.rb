class Favouriteknocker < ActiveRecord::Base
	belongs_to :favourited, class_name: "Knocker"
	belongs_to :favourite, class_name: "Knocker"
	validates :favourited_id, presence: true
	validates :favourite_id, presence: true
end
