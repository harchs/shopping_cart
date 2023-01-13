require 'voucher'

class ShoppingCart
  attr_accessor :items

  CATEGORIES_EXEMPT_FROM_TAXES = ['books', 'food', 'medical']

  def initialize
    @items = []
  end

  def add_item(item, qty)
    taxes = calculate_taxes_per_item(item, qty)
    total = calculate_total_per_item(item, qty, taxes)
    items.push({ qty: qty, item: item, taxes: taxes, total: total })
  end

  def taxes
    items.reduce(0) { |sum, item| sum + item[:taxes] }
  end

  def total
    items.reduce(0) { |sum, item| sum + item[:total] }
  end

  def checkout
    voucher = Voucher.new(items, taxes, total)
    voucher.show
  end

  private

  def calculate_taxes_per_item(item, qty)
    basic_tax = 0
    import_duty = 0

    basic_tax = (qty * item.price * 0.1) if !CATEGORIES_EXEMPT_FROM_TAXES.include?(item.category)
    import_duty = (qty * item.price * 0.05) if item.is_imported

    (((basic_tax + import_duty) / 0.05).round * 0.05).round(2)
  end

  def calculate_total_per_item(item, qty, taxes)
    (qty * item.price + taxes).round(2)
  end
end
