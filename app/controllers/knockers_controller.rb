class KnockersController < ApplicationController
 def show
    @knocker = Knocker.find(params[:id])
 end

 def new
 	@knocker = Knocker.new
 end

 def create
 	@knocker = Knocker.create( knocker_params )
 end

 private

 def knocker_params
 	params.require(:knocker).permit(:avatar)
 end
end
