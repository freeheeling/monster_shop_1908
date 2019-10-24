class SessionsController < ApplicationController
  def login
    flash[:error] = 'You are already logged in!'
    redirect_login if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back, #{user.name}!"
      redirect_login
    else
      flash[:error] = 'The email and password you entered did not match our records. Please double-check and try again.'
      render :login
    end
  end

  def logout
    reset_session
    flash[:success] = 'You have successfully logged out!'
    redirect_to welcome_path
  end

  private

  def redirect_login
    if merchant_employee? || merchant_admin?
      redirect_to merchant_dashboard_path
    elsif site_admin?
      redirect_to admin_path
    else
      redirect_to profile_path
    end
  end
end
