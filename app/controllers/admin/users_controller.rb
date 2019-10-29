# frozen_string_literal: true

class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:user_id])
  end

  def toggle_enabled
    user = User.find(params[:user_id])
    is_enabled = user.enabled?
    user.update_attributes(enabled?: !is_enabled)
    if !is_enabled
      flash[:notice] = "#{user.name} has been enabled!"
    else
      flash[:notice] = "#{user.name} has been disabled!"
    end
    redirect_to admin_users_path
  end
end
