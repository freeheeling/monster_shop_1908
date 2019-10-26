class UserOrdersController < ApplicationController

  def index; end

  def show
    @order = Order.where(id: params[:id], user_id: current_user.id).first
    render_404 unless @order
  end

end