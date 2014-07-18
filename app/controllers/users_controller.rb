class UsersController < ApplicationController
  skip_before_filter :session_exists, :only => [:new, :create]
  def new
    @user = User.new
  end
  def create
    @user = User.new params[:user]
    if @user.save
      sign_in @user
      redirect_to "/"
    else
      render 'new'
    end
  end
  def show
    @user = User.find_by_id(params[:id])
  end
  def index
    @user = User.first # change to current user
    @users = []
    @user.groups.each do |group|
      group.members.each do |user|
        if !@users.include? user
          @users.push(user)
        end
      end
    end
  end
end
