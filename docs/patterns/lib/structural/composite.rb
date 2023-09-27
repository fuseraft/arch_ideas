# Component interface
class Item
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def price
    raise NotImplementedError, "Subclasses must implement the price method"
  end

  def description
    raise NotImplementedError, "Subclasses must implement the description method"
  end
end

# Leaf
class Product < Item
  def initialize(name, price)
    super(name)
    @price = price
  end

  def price
    @price
  end

  def description
    @name
  end
end

# Composite
class Combo < Item
  def initialize(name)
    super(name)
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def remove_item(item)
    @items.delete(item)
  end

  def price
    @items.inject(0) { |sum, item| sum + item.price }
  end

  def description
    @items.map(&:description).join(", ")
  end
end

product1 = Product.new("Burger", 3.99)
product2 = Product.new("Fries", 1.99)
product3 = Product.new("Soda", 0.99)

combo1 = Combo.new("Combo 1")
combo1.add_item(product1)
combo1.add_item(product2)

combo2 = Combo.new("Combo 2")
combo2.add_item(product1)
combo2.add_item(product2)
combo2.add_item(product3)

puts combo1.description  # Burger, Fries
puts combo1.price  # 5.98

puts combo2.description  # Burger, Fries, Soda
puts combo2.price  # 6.97
