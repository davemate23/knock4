class AvailabilitiesController < ApplicationController

# This was controller was created to allow users to select their Availability from a calendar.  Unfortunately I had trouble with the front-end Javascript/JQuery form so didn't get far in the controller, however the Model is pretty much how I wanted it.  This should allow users to click a date on a calendar once to add their knocker_id and that date to the availability table, and again to remove it (changine the date to green/red).

	def new
		@availability = Availability.new
	end

	def show
		@availability = Availability.find(params[:id])
	end

end
