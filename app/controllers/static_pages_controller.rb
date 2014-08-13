class StaticPagesController < ApplicationController
  # Basic controller for any non-dynamic pages.
  def home
  	if signed_in?
  		@hype = current_knocker.hypes.build
  		@feed_items = current_knocker.feed.page params[:page]
  	  @availability = Availability.new
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
