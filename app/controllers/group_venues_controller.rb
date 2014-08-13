class GroupVenuesController < ApplicationController
	# I don't think these join table controllers are actually required now that I have changed the Routes (see VenueController for more useful notes).
	before_filter :authenticate_knocker!, only: [:new, :edit, :create, :update, :destroy]
	before_filter :authorize_venue || :authorize_group

	respond_to :html, :json

	def index
		@group_venues = GroupVenue.all.paginate(page: params[:page]).order('created_at DESC')
	end

	def new
		@group_venue = GroupVenue.new
	end

	def edit
		@venue = Venue.find(params[:id])
	end

	def create(group_venue)
		@group_venue = Venue.groups.create(venue_params)
 		respond_to do |format|
      		if @venue.save!
        		format.html { redirect_to @group_venue, notice: 'Group was successfully added to the Venue.' }
        		format.json { render json: @group_venue, status: :created, location: @group_venue }
      		else
        		format.html { render action: "new" }
        		format.json { render json: @venue.errors, status: :unprocessable_entity }
      		end
    	end
	end

	def create(venue_group)

	def update
		@venue = Venue.find(params[:id])
		@venue.update_attributes(venue_params)
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

	private

	def venue_params
  		params.require(:venue).permit(:admin, :avatar, :name, :identity, :address1, :address2, :town, :county, :country, :description, :postcode, :disabled, :parking, :toilets, :food, :drink, :alcohol, :changing, :baby_changing, :phone, :website, :knocker_venues_attributes => [:admin])
  	end

  	def authorize_venue
  		@venue = Venue.find(params[:id])
		knockervenue = KnockerVenue.where("knocker_id = ? and venue_id = ?", current_knocker.id, @venue.id).first
		if knockervenue.present?  && knockervenue.admin == 1
		else redirect_to venue_path
		end
	end

	def authorize_group
  		@group = Group.find(params[:id])
		groupmember = GroupMember.where("knocker_id = ? and group_id = ?", current_knocker.id, @group.id).first
		if groupmember.present?  && groupmember.admin == 1
		else redirect_to group_path
		end
	end
end
