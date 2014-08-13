class VenueInterestsController < ApplicationController
	# I don't think this is needed now that I have changed the Routes (you should be able to use the parent model's controller), but it may be worth keeping it for the time being just in case.

	def index
		@venue = Venue.find_by_id(params[:venue_id])
		@interests = Interest.all.order(:title).page params[:page]
	end

	def edit_interests
		@venue = Venue.find(params[:id])
		@interests = Venue.all.paginate(page: params[:page]).order( 'name DESC')
	end

	def edit_venues
		@interest = Interest.find(params[:id])
		@venues = Venue.all.paginate(page: params[:page]).near(:origin => @knocker).order('distance DESC')
	end

	def destroy
		@venue = Venue.find(params[:id])
		@interest = Interest.find(params[:id])
		@venue_interest = VenueInterest.find(params[venue_id: @venue.id, interest_id: @interest.id])
		if @venue_interest.present?
			@venue_interest.destroy
		end
		redirect_to venue_edit_interests_path
	end

	def update_interests
		@venue = Venue.find(params[:id])
		@interest = Interest.find(params[:id])
		@venue.interests.update_attributes(params[:venue_params])
		respond_to do |format|
      		if @venue.save!
        		format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        		format.json { render json: @venue, status: :created, location: @venue }
      		else
        		format.html { render action: "new" }
        		format.json { render json: @venue.errors, status: :unprocessable_entity }
      		end
    	end
	end
end

