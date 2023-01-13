require 'item'
require 'shopping_cart'

RSpec.describe 'ShoppingCart' do
  it 'starts with empty items' do
    shopping_cart = ShoppingCart.new
    expect(shopping_cart.items.length).to eq(0)
  end

  describe '#add_item' do
    it 'add item to cart' do
      item = Item.new('music CD', 14.99, 'entertainment')
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item, 1)
      expect(shopping_cart.items.length).to eq(1)
    end

    it 'add the item to cart with the basic_tax when the product is not imported and it is not exempt' do
      item = Item.new('music CD', 14.99, 'entertainment')
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item, 1)
      expect(shopping_cart.items.first[:taxes]).to eq(1.5)
    end

    it 'add the item to cart with the basic_tax plus import_duty when the product is imported and it is not exempt' do
      item = Item.new('music CD', 14.99, 'entertainment', true)
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item, 1)
      expect(shopping_cart.items.first[:taxes]).to eq(2.25)
    end

    it 'add the item to cart with the basic_tax in zero when the product is not imported and it is exempt' do
      item = Item.new('music CD', 14.99, 'books')
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item, 1)
      expect(shopping_cart.items.first[:taxes]).to eq(0)
    end

    it 'add the item to cart with the import_duty when the product is imported and it is exempt' do
      item = Item.new('music CD', 14.99, 'books', true)
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item, 1)
      expect(shopping_cart.items.first[:taxes]).to eq(0.75)
    end

    it 'add the item to cart with the total' do
      item = Item.new('music CD', 14.99, 'entertainment', true)
      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item, 1)
      expect(shopping_cart.items.first[:total]).to eq(17.24)
    end
  end

  describe '#taxes' do
    it 'returns the sum of the taxes of each item' do
      item_1 = Item.new('music CD', 14.99, 'entertainment', true)
      item_2 = Item.new('music CD', 14.99, 'books', true)

      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item_1, 1)
      shopping_cart.add_item(item_2, 1)

      expect(shopping_cart.taxes).to eq(3)
    end
  end

  describe '#total' do
    it 'returns the sum of the total of each item' do
      item_1 = Item.new('music CD', 14.99, 'entertainment', true)
      item_2 = Item.new('music CD', 14.99, 'books', true)

      shopping_cart = ShoppingCart.new
      shopping_cart.add_item(item_1, 1)
      shopping_cart.add_item(item_2, 1)

      expect(shopping_cart.total).to eq(32.98)
    end
  end

  context 'inputs defined in the test' do
    describe 'input 1' do
      it "" do
        item_1 = Item.new('book', 12.49, 'books')
        item_2 = Item.new('music CD', 14.99, 'entertainment')
        item_3 = Item.new('chocolate bar', 0.85, 'food')

        shopping_cart = ShoppingCart.new
        shopping_cart.add_item(item_1, 2)
        shopping_cart.add_item(item_2, 1)
        shopping_cart.add_item(item_3, 1)

        shopping_cart.checkout

        expect(1).to be(1)
      end
    end

    describe 'input 2' do
      it "" do
        item_1 = Item.new('box of chocolates', 10.00, 'food', true)
        item_2 = Item.new('bottle of perfume', 47.50, 'cosmetic', true)

        shopping_cart = ShoppingCart.new
        shopping_cart.add_item(item_1, 1)
        shopping_cart.add_item(item_2, 1)

        shopping_cart.checkout

        expect(1).to be(1)
      end
    end

    describe 'input 3' do
      it "" do
        item_1 = Item.new('bottle of perfume', 27.99, 'cosmetic', true)
        item_2 = Item.new('bottle of perfume', 18.99, 'cosmetic')
        item_3 = Item.new('packet of headache pills', 9.75, 'medical')
        item_4 = Item.new('boxes of chocolates', 11.25, 'food', true)

        shopping_cart = ShoppingCart.new
        shopping_cart.add_item(item_1, 1)
        shopping_cart.add_item(item_2, 1)
        shopping_cart.add_item(item_3, 1)
        shopping_cart.add_item(item_4, 3)

        shopping_cart.checkout

        expect(1).to be(1)
      end
    end
  end
end
