class ProfilesController < ApplicationController
	# I created this controller, as I found it difficult to disassociate the attributes for knocker accounts and profiles with Devise.  Should allow users to update their profile details without entering their password, etc everytime and means they can change their email, name, etc in a Settings page.

	def new
		@profile = Profile.new
	end

	def show
		@profile = !params[:knocker_id].nil? ? Profile.find(params[:knocker_id]) : current_knocker.profile
	end


	def edit
		@profile = current_knocker.profile
	end

	def update
		@profile = current_knocker.profile
		@profile.update_attributes(profile_params)
		respond_to do |format|
	    	if @profile.update_attributes(profile_params)
	      		format.html { redirect_to(knocker_profile_path, :notice => 'Your Profile was successfully updated.') }
	      		format.json { respond_with_bip(@profile) }
	    	else
	      		format.html { render :action => "edit" }
	      		format.json { respond_with_bip(@profile) }
	    	end
  		end

	end

	private

	def profile_params
  		params.require(:profile).permit(:about, :nationality, :occupation, :employer, :transport)
  	end
end
