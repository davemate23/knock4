class PostsController < ApplicationController
  before_action :authenticate_knocker!, only: [:create, :destroy]
  before_filter :find_postable, except: [:index]

  def new
    @post = Post.new
  end

  def index
  end

  def create
  	@postable = find_postable
  	@post = @postable.posts.build(post_params)
    @post.knocker = current_knocker

  	if @post.save
  		flash[:success] = "Post created!"
  		redirect_to :id => @postable.id
  	else
      @feed_items = []
  		render 'static_pages/home'
  	end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.present?
      @post.destroy
    end
    redirect_to root_url
  end

  private

  	def post_params
  		params.require(:post).permit(:content)
  	end

    def find_postable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
