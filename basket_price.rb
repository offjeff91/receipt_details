# frozen_string_literal: true

require_relative 'item_price'

class BasketPrice
  def initialize(items:)
    @items = items
    @item_prices = {}
  end

  def calculate
    {
      total: @items.sum { |item| price(item)[:item_total] },
      tax: @items.sum { |item| price(item)[:item_tax] }
    }
  end

  protected

  def price(item)
    @item_prices[item] ||= ItemPrice.new(item).calculate
  end
end
