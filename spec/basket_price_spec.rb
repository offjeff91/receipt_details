# frozen_string_literal: true

require_relative '../basket_price'
require_relative '../item_price'
describe BasketPrice do
  before do
    @items = [{ item: 1 }, { item: 2 }]
    @item_price_double = double(calculate: { item_total: 10.0, item_tax: 2.0 })

    expect(ItemPrice).to receive(:new).with({ item: 1 }).and_return(@item_price_double)
    expect(ItemPrice).to receive(:new).with({ item: 2 }).and_return(@item_price_double)

    @basket_price = BasketPrice.new(items: @items)
  end

  it 'should sum item prices' do
    expect(@basket_price.calculate[:total]).to eq(20.0)
  end
  it 'should sum item taxes' do
    expect(@basket_price.calculate[:tax]).to eq(4.0)
  end
end
