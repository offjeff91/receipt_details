# frozen_string_literal: true

require_relative '../item_price'
describe ItemPrice do
  context 'Exempted Item' do
    context 'National Item' do
      it 'should calculate original price' do
        item_price = ItemPrice.new(
          item: {
            price: 50.0,
            type: :book,
            imported?: false
          }
        )

        expect(item_price.calculate).to eq({
                                             item_total: 50.0,
                                             item_tax: 0
                                           })
      end
    end
    context 'Imported Item' do
      it 'should calculate price with import tax' do
        item_price = ItemPrice.new(
          item: {
            price: 50.0,
            type: :book,
            imported?: true
          }
        )

        expect(item_price.calculate).to eq({
                                             item_total: 52.5,
                                             item_tax: 2.5
                                           })
      end
    end
  end
  context 'Non Exempted Item' do
    context 'National Item' do
      it 'should calculate price with sales tax' do
        item_price = ItemPrice.new(
          item: {
            price: 50.0,
            type: :other,
            imported?: false
          }
        )

        expect(item_price.calculate).to eq({
                                             item_total: 55.0,
                                             item_tax: 5.0
                                           })
      end
    end
    context 'Imported Item' do
      it 'should calculate price with both sales and import tax' do
        item_price = ItemPrice.new(
          item: {
            price: 50.0,
            type: :other,
            imported?: true
          }
        )

        expect(item_price.calculate).to eq({
                                             item_total: 57.5,
                                             item_tax: 7.5
                                           })
      end
    end
  end
end
