module SessionsHelper
  def sign_in(user)
    cookies[:remember_token] = user.remember_token
    self.current_user = user
  end
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  def signed_in?
    puts "CURRENT USER"
    puts current_user
    puts current_user.nil?
    !current_user.nil?
  end


end
