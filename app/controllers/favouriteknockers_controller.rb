class FavouriteknockersController < ApplicationController
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