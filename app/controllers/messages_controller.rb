class MessagesController < ApplicationController
  # Part of the Mailboxer Gem
 
  # GET /message/new
  def new
    @knocker = Knocker.find(params[:knocker])
    @message = current_knocker.messages.new
  end
 
   # POST /message/create
  def create
    @recipient = Knocker.find(params[:knocker])
    current_knocker.send_message(@recipient, params[:body], params[:subject])
    flash[:notice] = "Message has been sent!"
    redirect_to :conversations
  end
end