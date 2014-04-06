class KnockersController < ApplicationController
before_filter :authenticate_knocker!, only: [:index, :show,:edit, :update]
 def index
 	@knockers = Knocker.all_except(current_knocker).paginate(page: params[:page]).order('created_at DESC')
 end

 def show
    @knocker = Knocker.find(params[:id])
 end

 def new
 	@knocker = Knocker.new
 end

 def edit
    @knocker = User.find(params[:id])
 end

 def update
   	@knocker = Knocker.find(params[:id])
   	if @knocker.update_attributes(knocker_params)
    	# Handle a successful update.
  	else
    	render 'edit'
   	end
 end

 def create
 	@knocker = Knocker.create( knocker_params )
 end

 private

 def knocker_params
 	params.require(:knocker).permit(:avatar, :username, :first_name, :last_name, :gender, :birthday, :postcode, :latitude, :longitude)
 end
end
