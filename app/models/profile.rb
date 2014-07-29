class Profile < ActiveRecord::Base

	belongs_to :knocker

	def name
		self.knocker.first_name + " " + self.knocker.last_name[0]
	end
end
