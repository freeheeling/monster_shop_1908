# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:user_id])
  end
end
