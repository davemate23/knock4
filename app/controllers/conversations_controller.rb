class ConversationsController < ApplicationController

  #This was automatically created, then adjusted through the Mailboxer Gem.  Needs a bit of work to get up and running effectively, although it does work.  Best to read the notes for the Gem, rather than me trying to explain it all.
  before_filter :authenticate_knocker!
  helper_method :mailbox, :conversation
  def index
    @conversations ||= current_knocker.mailbox.inbox.all
  end

  def reply
    current_knocker.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trashbin     
    @trash ||= current_knocker.mailbox.trash.all   
  end

  def trash  
    conversation.move_to_trash(current_knocker)  
    redirect_to :conversations 
  end 

  def untrash  
    conversation.untrash(current_knocker)  
    redirect_to :back 
  end

  def empty_trash   
    current_knocker.mailbox.trash.each do |conversation|    
      conversation.receipts_for(current_knocker).update_all(:deleted => true)
    end
    redirect_to :conversations
  end

  private
 
  def mailbox
   @mailbox ||= current_knocker.mailbox
  end
   
  def conversation
   @conversation ||= mailbox.conversations.find(params[:id])
  end
   
  def conversation_params(*keys)
   fetch_params(:conversation, *keys)
  end
   
  def message_params(*keys)
   fetch_params(:message, *keys)
  end
   
  def fetch_params(key, *subkeys)
   params[key].instance_eval do
     case subkeys.size
     when 0 then self
     when 1 then self[subkeys.first]
     else subkeys.map{|k| self[k] }
     end
   end
  end

end