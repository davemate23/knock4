class EventsController < ApplicationController
  #Controller for Events Model.  
  before_filter :authenticate_knocker!, only: [:new, :edit, :create, :update, :destroy]
  before_filter :authorise_event_admin, only: [:edit]
  after_filter :set_admin_for_event, only: [:create]
  
  def index
    @events = Event.paginate(page: params[:page]).order('start_time DESC') #
  end

  def new
  	@event = Event.new
  end

  def create
  	@event = current_knocker.events.create(event_params) #Should create a linked event to the current knocker
    respond_to do |format|
          if @event.save!
            format.html { redirect_to @event, notice: 'Event was successfully created.' }
            format.json { render json: @event, status: :created, location: @event }
          else
            format.html { render action: "new" }
            format.json { render json: @event.errors, status: :unprocessable_entity }
          end
      end
  end

  def show
    #This allows the Event profile page to display various instances on the page, including those of other models.
    @event = Event.find(params[:id])
    @knockers = @event.knockers.paginate(page: params[:page])
    @interests = @event.interests.paginate(page: params[:page])
    @venues = @event.venues.paginate(page: params[:page])
    @groups = @event.groups.paginate(page: params[:page])
  end

  def update
    @event = Event.find(params[:id])
    @event.update_attributes(event_params)
    respond_to do |format|
        if @event.update_attributes(event_params)
            format.html { redirect_to(@event, :notice => 'Your Event was successfully updated.') }
            format.json { respond_with_bip(@event) }
        else
            format.html { render :action => "edit" }
            format.json { respond_with_bip(@event) }
        end
      end
  end

  private

	def event_params
  		params.require(:event).permit(:admin, :name, :avatar, :start_time, :end_time, :description, :website)
  end

  def set_admin_for_event
    # I'm almost certain that there is a better way to do this.  This was to set the current_knocker as the event admin on creation, unfortunately I had a real struggle trying to effectively access the attributes within the join table from the controller, so this was the best I could do.
      kv = EventAttendance.where(knocker_id: current_knocker.id, event_id: Event.last.id).first
      kv.update_attribute(:admin, kv.admin = 1)
      kv.save
  end

  def authorise_event_admin
    # This checks whether or not the current_knocker is an admin of the Event, and therefore will allow a method for the view to display extra features (such as the Edit Event link).
    @event = Event.find(params[:id])
    eventattendance = EventAttendance.where("knocker_id = ? and event_id = ?", current_knocker.id, @event.id).first # eventattendance turned out to be an association, not an attribute so I had to use a .first to select the attribute... probably a better way to do this!
    if eventattendance.present?  && eventattendance.admin == 1
    else redirect_to event_path
    end
  end
end