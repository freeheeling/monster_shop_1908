# frozen_string_literal: true

class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = Order.find(params[:order_id])
    @item_orders = @order.find_order(current_user.merchant_id)
  end
end
