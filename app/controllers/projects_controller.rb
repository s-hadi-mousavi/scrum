class ProjectsController < ApplicationController
  def new
    @user = current_user
    @project = Project.new
  end
  def create
    @project = Project.new(params[:project])
    @project.mods << current_user
    @project.members << current_user
    
    if @project.save
      redirect_to "/projects"
    else
      render 'new'
    end
  end
  def index
    @projects = current_user.projects
  end
  def browse
    @projects = []
    @groups = current_user.groups
    @groups.each do |g|
      g.projects.each do |p|
        if !@projects.include? p
          @projects.push p
        end
      end
    end
    render 'index'
  end
  def show
    @project = Project.find(params[:id])
    @users = @project.members
    @mods = @project.mods
    if !@project
      redirect_to "/projects"
    end
  end
  def destroy
    @project = Project.find(params[:id])
    @project.tasks.each do |t|
      t.destroy
    end
    @project.destroy
    redirect_to request.referer
  end
  def addtask
    @task = Task.new()
    @task.description = params[:description]
    @task.project_id = params[:project_id]
    @task.group_id = Project.find(params[:project_id]).group_id
    @task.users << current_user
    @task.save
    render @task
  end
  def kick
    @user = User.find(params[:user_id])
    @project = Project.find(params[:id])
    #Add code to remove from all tasks and subtasks too
    if @project.members.include? @user
      @project.members.delete(@user)
    end
    if @project.mods.include? @user
      @project.mods.delete(@user)
    end
  end
  def join
    @project = Project.find(params[:id])
    @prequests = @project.prequests.where("user_id = ?", current_user.id)
    if @project and current_user.groups.include? @project.group
      if !@prequests.any?
        @prequest = Prequest.new(user_id: current_user.id,
                            project_id: @project.id)
        if @prequest.save
          redirect_to project_path(@project)
        else
          flash["error"] = "Could not create a request"
          redirect_to request.referer
        end
      else
        flash["error"] = "You have already requested to join"
        redirect_to request.referer
      end
    else
      flash["error"] = "Not a valid project"
      redirect_to request.referer
    end
  end
  def accept
    @prequest = Prequest.find(params[:prequest_id])
    @prequest.project.members << @prequest.user
    @prequest.delete
    redirect_to request.referer
  end
  def decline
    @prequest = Prequest.find(params[:prequest_id])
    @prequest.delete
    redirect_to request.referer
  end
end
