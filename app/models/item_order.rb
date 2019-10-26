# frozen_string_literal: true

class ItemOrder < ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order
  has_one :merchant, through: :item

  def subtotal
    price * quantity
  end
end
