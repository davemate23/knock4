class AvailabilitiesController < ApplicationController

def new
	@availability = Availability.new
end

def show
	@availability = Availability.find(params[:id])
end

end
