class FavouriteknockersController < ApplicationController
	# I seriously messed this bit up, and was going to get back to it later but unfortunately never got around to it!
	# Following the Michael Hartl Twitter-Style tutorial, I confused myself with the naming convention, therefore it may be worth starting from scratch on the Follower/Following part!
	before_action :authenticate_knocker!

	def create
		@knocker = Knocker.find(params[:favouriteknocker][:favourite_id])
		current_knocker.favourite!(@knocker)
		redirect_to @knocker
	end

	def destroy
		@knocker = Favouriteknocker.find(params[:id]).favourite
		current_knocker.unfavourite!(@knocker)
		redirect_to @knocker
	end
end