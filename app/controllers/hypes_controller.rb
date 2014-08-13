class HypesController < ApplicationController
  # Pretty straight forward controller, although I think I started having trouble with them again for the latter part of development due to the addition of the find_hypable definition taken from the Railscast on polymorphic relationships.
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
      # Seriously struggled with this.  This is supposed to turn a REST url into a model and instance, however I struggled to do this.
      # This is supposed to allow various models to post Hype (ie a Knocker, Venue, Group or Event admin to post Hype as that relative entity), maybe you might have a bit more luck (or understanding) implementing it!?
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end