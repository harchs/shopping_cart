class Item
  attr_accessor :name, :price, :category, :is_imported

  def initialize(name, price, category, is_imported = false)
    @name = name
    @price = price
    @category = category
    @is_imported = is_imported
  end
end
