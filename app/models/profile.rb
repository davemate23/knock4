class Profile < ActiveRecord::Base
	# I tried to move as many non-essential details into here as I could, but couldn't actually find that many.  There's the option to have loads of random bits of info, but we'll see what happens.

	belongs_to :knocker

	# Creates a display name for knocker's profile page.
	def name
		self.knocker.first_name + " " + self.knocker.last_name[0]
	end
end
