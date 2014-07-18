class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :load_header_vars
  before_filter :session_exists, except: [:home]
  def home
  end
  def session_exists
      puts "CHECKING SESSION EXISTS"
    if !signed_in?
      puts "NO SESSION EXISTS"
           
      puts cookies[:remember_token]
      redirect_to "/signin"
    end
  end

	def load_header_vars
    if signed_in?
      @hgroups = current_user.groups
      @hprojects = current_user.projects
      @htasks = current_user.tasks
    end
	end
end
