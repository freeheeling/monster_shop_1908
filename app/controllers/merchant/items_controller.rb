# frozen_string_literal: true

class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.merchant.items
  end

  def activate_deactivate
    if params[:activate_deactivate] == 'deactivate'
      item = Item.find(params[:item_id])
      item.toggle!(:active?)
      flash[:notice] = "#{item.name} is now deactivated and is no longer for sale."
      redirect_to merchant_user_items_path
    end
  end
end
