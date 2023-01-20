# frozen_string_literal: true

class ItemPrice
  SALES_TAX_EXEMPTIONS = %i[book food medical].freeze

  def initialize(item:)
    @item = item
  end

  def calculate
    {
      item_total: (price + sales_tax + import_tax) * quantity,
      item_tax: (sales_tax + import_tax) * quantity
    }
  end

  protected

  def price
    @price ||= @item[:price]
  end

  def type
    @type ||= @item[:type]
  end

  def imported?
    @imported ||= @item[:imported?]
  end

  def quantity
    @quantity ||= @item[:quantity]
  end

  def sales_tax
    return 0 if SALES_TAX_EXEMPTIONS.include? type

    price * 0.1
  end

  def import_tax
    return 0 unless imported?

    price * 0.05
  end
end
