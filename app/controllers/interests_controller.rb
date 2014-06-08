class InterestsController < ApplicationController

	def index
	end

	def show
		@interest = Interest.find(params[:id])
	end

	def new
	  	@interest = Interest.new
	end

	def create
		@interest = Interest.create(interest_params)
		@interest.get_content
		 if @interest.save
    		redirect_to root_path
  		else
    		render 'static_pages/home'
  		end
	end


	private 

	def interest_params
  		params.require(:interest).permit(:title, :wikipedia)
  	end
end