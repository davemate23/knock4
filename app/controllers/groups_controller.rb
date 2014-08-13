class GroupsController < ApplicationController
  # Most of this is just copy & pasted from the other model Controllers.  I didn't do much work on Groups.
  before_filter :authenticate_knocker!, except: [:show, :index]
  before_filter :authorize_admin, only: [:edit]
  after_filter :set_admin_for_group, only: [:create]


  def index
    @groups = Group.all.paginate(page: params[:page]).order('created_at DESC')
  end

  def new
  	@group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
  	@group = current_knocker.groups.create(group_params)
    respond_to do |format|
          if @group.save!
            format.html { redirect_to @group, notice: 'Group was successfully created.' }
            format.json { render json: @group, status: :created, location: @group }
          else
            format.html { render action: "new" }
            format.json { render json: @group.errors, status: :unprocessable_entity }
          end
    end
  end

  def show
    @group = Group.find(params[:id])
    @venues = @group.venues.paginate(page: params[:page])
    @interests = @group.interests.paginate(page: params[:page])
    @knockers = @group.knockers.paginate(page: params[:page])
    @events = @group.events.paginate(page: params[:page])
    @hypes = Hype.where(hypeable: @group)
  end

  def update
    @group = Group.find(params[:id])
    @group.update_attributes(group_params)
    respond_to do |format|
      if @group.update_attributes(group_params)
          format.html { redirect_to(@group, :notice => 'Your Group was successfully updated.') }
          format.json { respond_with_bip(@group) }
      else
          format.html { render :action => "edit" }
          format.json { respond_with_bip(@group) }
      end
    end
  end

  private

	def group_params
  		params.require(:group).permit(:admin, :avatar, :name, :description, :website, :phone, :group_members_attributes => [:admin])
  end

  def set_admin_for_group
      gm = GroupMember.where(knocker_id: current_knocker.id, group_id: Group.last.id).first
      gm.update_attribute(:admin, gm.admin = 1)
      gm.save
  end

  def authorize_admin
      @group = Group.find(params[:id])
    groupmember = GroupMember.where("knocker_id = ? and group_id = ?", current_knocker.id, @group.id).first
    if groupmember.present?  && groupmember.admin == 1
    else redirect_to group_path
    end
  end
end
