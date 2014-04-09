class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@hype = current_knocker.hypes.build
  		@feed_items = current_knocker.feed.paginate(page: params[:page])
  	end
  end

  def help
  end

  def about
  end

  def contact
  end
end
