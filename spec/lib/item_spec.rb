require 'item'

RSpec.describe 'Item' do
  it 'has a name' do
    item = Item.new('box of chocolates', 10.00, 'food', true)
    expect(item.name).to eq('box of chocolates')
  end

  it 'has a price' do
    item = Item.new('box of chocolates', 10.00, 'food', true)
    expect(item.price).to eq(10.00)
  end

  it 'has a category' do
    item = Item.new('box of chocolates', 10.00, 'food', true)
    expect(item.category).to eq('food')
  end

  describe '#is_imported' do
    context 'when is not sent in the initialize' do
      it 'returns false' do
        item = Item.new('box of chocolates', 10.00, 'food')
        expect(item.is_imported).to be_falsy
      end
    end

    context 'when is sent in the initialize' do
      it 'returns true' do
        item = Item.new('box of chocolates', 10.00, 'food', true)
        expect(item.is_imported).to be_truthy
      end

      it 'returns false' do
        item = Item.new('box of chocolates', 10.00, 'food', false)
        expect(item.is_imported).to be_falsy
      end
    end
  end
end
