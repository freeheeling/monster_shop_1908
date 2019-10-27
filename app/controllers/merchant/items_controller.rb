# frozen_string_literal: true

class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = current_user.merchant.items
  end

  def new; end

  def create
    merchant = current_user.merchant
    item = merchant.items.create(item_params)
    if item.save
      flash[:success] = 'Item was successfully created!'
      redirect_to merchant_user_items_path
    else
      flash[:error] = item.errors.full_messages.to_sentence
      render :new
    end
  end

  def activate_deactivate
    if params[:activate_deactivate] == 'deactivate'
      item = Item.find(params[:item_id])
      item.toggle!(:active?)
      flash[:notice] = "#{item.name} is now deactivated and is no longer for sale."
      redirect_to merchant_user_items_path
    end
  end

  private

  def item_params
    params.permit(:name, :description, :price, :inventory, :image)
  end
end
