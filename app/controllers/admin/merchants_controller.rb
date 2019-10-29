
# frozen_string_literal: true

class Admin::MerchantsController < Admin::BaseController
  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def toggle_active
    merchant = Merchant.find(params[:merchant_id])
    is_enabled = merchant.enabled?
    merchant.update_attributes(enabled?: !is_enabled)
    redirect_to merchants_path
  end
end
