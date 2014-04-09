class HypesController < ApplicationController
  before_action :authenticate_knocker!, only: [:create, :destroy]
  before_action :correct_knocker, only: :destroy

  def index
  end

  def create
  	@hype = current_knocker.hypes.build(hype_params)
  	if @hype.save
  		flash[:success] = "Hype created!"
  		redirect_to root_url
  	else
      @feed_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
    @hype.destroy
    redirect_to root_url
  end

  private

  	def hype_params
  		params.require(:hype).permit(:content)
  	end

    def correct_knocker
      @hype = current_knocker,hypes.find_by(id: params[:id])
      redirect_to root_url if @hype.nil?
    end
end