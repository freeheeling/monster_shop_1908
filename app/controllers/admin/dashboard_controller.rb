# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.sort_orders
  end
end
