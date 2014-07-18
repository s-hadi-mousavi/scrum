class TasksController < ApplicationController
  def new
    @user = current_user
    @task = Task.new
  end
  def create
    @task = Task.new(params[:task])
    @task.users << current_user
    @task.group_id = @task.project.group.id
    
    if @task.save
      redirect_to task_path(@task)
    else
      render 'new'
    end
  end
  def index
    @tasks = current_user.tasks
  end
  def browse
    @tasks = []
    @projects = current_user.projects
    @projects.each do |p|
      p.tasks.each do |t|
        if !@tasks.include? t
          @tasks.push t
        end
      end
    end
    render 'index'
  end
  def show
    @task = Task.find(params[:id])
    @users = @task.users
  end
  def destroy
    @task = Task.find(params[:id])
    @task.tasks.each do |t|
      t.destroy
    end
    puts "-------------------------"
    puts "Destroying Task"
    puts @task.destroy
    puts "-------------------------"
    redirect_to "/tasks"
  end
  def kick
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    #Add code to remove from all tasks and subtasks too
    if @task.users.include? @user
      @task.users.delete(@user)
    end
  end
  def join
    @task = Task.find(params[:id])
    @trequests = @task.trequests.where("user_id = ?", current_user.id)
    if @task and current_user.projects.include? @task.project
      if !@trequests.any?
        @trequest = Trequest.new(user_id: current_user.id,
                            task_id: @task.id)
        if @trequest.save
          redirect_to task_path(@task)
        else
          flash["error"] = "Could not create a request"
          redirect_to request.referer
        end
      else
        flash["error"] = "You have already requested to join"
        redirect_to request.referer
      end
    else
      flash["error"] = "Not a valid task"
      redirect_to request.referer
    end
  end
  def accept
    @trequest = Trequest.find(params[:trequest_id])
    @trequest.task.users << @trequest.user
    @trequest.delete
    redirect_to request.referer
  end
  def decline
    @trequest = Trequest.find(params[:trequest_id])
    @trequest.delete
    redirect_to request.referer
  end
end
