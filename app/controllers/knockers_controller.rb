class KnockersController < ApplicationController
  #  This should be relatively straight forward.
before_filter :authenticate_knocker!, only: [:index, :show,:edit, :update, :destroy, :favourite_knockers, :favourited_knockers]
 def index
 	@knockers = Knocker.all_except(current_knocker).page params[:page]
 end

 def show
    @knocker = Knocker.find(params[:id])
    @hypes = @knocker.hypes.page(params[:page]).per(40) # Allows for a newsfeed on user's profile page.
    @posts = Post.page(params[:page]).per(40) #As above, although needs to display just the Posts to the specific Knocker.
 end

 def message_form
  # Part of Mailboxer
  respond_to do |format|
    format.html
    format.js
  end
 end

 def new
 	@knocker = Knocker.new
  @message = Message.new   # Part of Mailboxer
 end

 def edit
    @knocker = Knocker.find(params[:id])
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

 def favourite_knockers
  # As with the favouriteknocker controller, this is pretty messed up.
 	@title = "Favourites"
 	@knocker = Knocker.find(params[:id])
 	@knockers = @knocker.favourite_knockers.paginate(page: params[:page])
 	render 'show_favourite'
 end

 def favourited_knockers
  # As with the favouriteknocker controller, this is pretty messed up.
 	@title = "Listed as a Favourite by"
 	@knocker = Knocker.find(params[:id])
 	@knockers = @knocker.favourited_knockers.paginate(page: params[:page])
 	render 'show_favourite'
 end

 private

 def knocker_params
 	params.require(:knocker).permit(:avatar, :identity, :first_name, :last_name, :gender, :birthday, :postcode, :latitude, :longitude)
 end
end
