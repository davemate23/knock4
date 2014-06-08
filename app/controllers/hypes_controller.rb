class HypesController < ApplicationController
  before_action :authenticate_knocker!, only: [:create, :destroy]
  before_filter :find_hypeable

  
  def new
    @hype = Hype.new
  end

  def create
  	@hype = @hypeable.hypes.build(hype_params)
    @hype.author_id = current_knocker.id

  	if @hype.save
  		flash[:success] = "Hype created!"
  		redirect_to :id => nil
  	else
      @feed_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
    @hype = Hype.find(params[:id])
    if @hype.present?
      @hype.destroy
    end
    redirect_to root_url
  end

  private

  	def hype_params
  		params.require(:hype).permit(:content)
  	end

    def find_hypeable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end