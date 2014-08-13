class Favouriteknocker < ActiveRecord::Base
	# Table of knockers who have favourited and been favourited. See controller for info on the mess I've made of this!
	belongs_to :favourited, class_name: "Knocker"
	belongs_to :favourite, class_name: "Knocker"
	validates :favourited_id, presence: true
	validates :favourite_id, presence: true
end
