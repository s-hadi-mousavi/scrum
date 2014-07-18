class GroupsController < ApplicationController
  def new
    @group = Group.new
  end
  def show
    @group = Group.find(params[:id])
  end
  def create
    @group = Group.new params[:group]
    if @group.save
      @group.members << current_user
      @group.mods << current_user
      redirect_to "/groups"
    else
      render 'new'
    end
  end
  def index
    @groups = current_user.groups
  end
  def browse
    @groups = Group.all
    render 'index'
  end
  def kick
    @user = User.find(params[:user_id])
    @group = Group.find(params[:id])
    #Add code to remove from all tasks and subtasks too
    if @group.members.include? @user
      @group.members.delete(@user)
    end
    if @group.mods.include? @user
      @group.mods.delete(@user)
    end
  end
  def join
    @group = Group.find(params[:id])
    @grequests = Grequest.where("user_id = ? AND group_id = ?", current_user.id, @group.id)
    puts "-----------------"
    puts @grequests
    puts @grequest.nil?
    if @group and !@group.members.include? current_user
      if !@grequests.any?
        @grequest = Grequest.new(user_id: current_user.id,
                            group_id: @group.id)
        if @grequest.save
          redirect_to group_path(@group)
        else
          flash["error"] = "Could not create a request"
          redirect_to request.referer
        end
      else
        flash["error"] = "You have already requested to join"
        redirect_to request.referer
      end
    else
      flash["error"] = "Already in Group"
      redirect_to request.referer
    end
  end
  def accept
    @grequest = Grequest.find(params[:grequest_id])
    @grequest.group.members << @grequest.user
    puts @grequest.group.id
    puts @grequest.group.members
    puts @grequest.user.groups
    @grequest.delete
    redirect_to request.referer
  end
  def decline
    @grequest = Grequest.find(params[:grequest_id])
    @grequest.delete
    redirect_to request.referer
  end
end
