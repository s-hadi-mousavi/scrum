class SessionsController < ApplicationController
  skip_before_filter :session_exists
  def new
   if signed_in?
    redirect_to '/'
    flash.alert = "You are already signed in"
   end
  end
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to '/'
    else
      flash.now[:error] = 'Invalid email/password combination' 
      render 'new'
    end
  end
  def destroy
    self.current_user = nil
    cookies.delete(:remember_token)
    redirect_to '/signin'
  end
end
