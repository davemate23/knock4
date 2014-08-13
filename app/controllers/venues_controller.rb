class VenuesController < ApplicationController
	# I believe this was the last Controller that I was fiddling around with, so has the most up-to-date features.
	before_filter :authenticate_knocker!, only: [:new, :edit, :create, :update, :destroy]
	before_filter :authorize_admin, only: [:edit]
	after_filter :set_admin_for_venue, only: [:create]

	respond_to :html, :json

	def index
		@q = Venue.search(params[:q]) #This was added after I included the Ransack Gem to allow knockers to filter results... didn't quite finish it though!
		@venues = @q.result.includes(:interests).page(params[:page]).per(40) # As above, but paginates the results.
	end

	def show
		@venue = Venue.find(params[:id])
		@interest = @venue.interests
		@hash = Gmaps4rails.build_markers(@venue) do |venue, marker| # Includes a Google Map of the Venue, various adaptations can be made for it, and I think in the future it would be worth having one where the Venue Admin can move the location around, as Postcodes aren't all that accurate on a map.
	  		marker.lat venue.latitude
	  		marker.lng venue.longitude
	  		marker.infowindow venue.name
  		end
	end

	def new
		@venue = Venue.new
	end

	def edit
		@venue = Venue.find(params[:id])
	end

	def create
		@venue = current_knocker.venues.create(venue_params) # Creates a Venue and associates with current_knocker in join table.
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

	def update
		# With this Update method, I was trying to introduce the ability for an admin to add an Interest to the Venue.
		# Here, when adding an Interest it uses the Update method to update the venue_interests table (although I can't remember how well this was working).
		@venue = current_knocker.venues.find(params[:id])
		@venue.update_attributes(venue_params)
		if params[:interest_ids].present?
			@venue.interests = Interest.where(id: params[:interest_ids])
			@venue.save
		end
		respond_to do |format|
	    	if @venue.update_attributes(venue_params)
	      		format.html { redirect_to(@venue, :notice => 'Your Venue was successfully updated.') }
	      		format.json { respond_with_bip(@venue) }
	    	else
	      		format.html { render :action => "edit" }
	      		format.json { respond_with_bip(@venue) }
	    	end
  		end
	end

	def destroy
	end

	def edit_interests
		# This allowed for an edit_interests page under the Venues view.  Took me ages to get the Routes right for this to work so that a million Controllers weren't needed!
		@venue = Venue.find(params[:id])
		@interest = @venue.interests.find_by(params[:venue_id])
		@interests = Interest.order(:name).page params[:page]
	end

	def update_interests
		# Can't quite remember, but I don't think this is used now that the Update method does it all.
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

	def delete_interests
		# I couldn't get this one to work.  I think it was literally the last thing I was working on.  I was trying to get a destroy method for the association between Venues and Interests without deleting the actual Instance of either... probably really straight forward, but I couldn't get it!.. good luck!
		@venue = Venue.find(params[:id])
		if @venue.interests.present?
			@venue.interests.delete
		end
		redirect_to @venue
	end

	private

	def venue_params
  		params.fetch(:venue, {}).permit(:admin, :avatar, :name, :identity, :address1, :address2, :town, :county, :country, :description, :postcode, :disabled, :parking, :toilets, :food, :drink, :alcohol, :changing, :baby_changing, :phone, :website, :interest_ids => [], :knocker_venues_attributes => [:admin])
  	end

  	def set_admin_for_venue
  		# Sets the admin on Venue creation.
  		kv = KnockerVenue.where(knocker_id: current_knocker.id, venue_id: Venue.last.id).first
  		kv.update_attribute(:admin, kv.admin = 1)
  		kv.save
  	end

  	def authorize_admin
  		# Checks if current_knocker is the admin for the page.
  		@venue = Venue.find(params[:id])
		knockervenue = KnockerVenue.where("knocker_id = ? and venue_id = ?", current_knocker.id, @venue.id).first
		if knockervenue.present?  && knockervenue.admin == 1
		else redirect_to venue_path
		end
	end
end
