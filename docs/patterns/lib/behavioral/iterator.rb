# Aggregate interface
class Collection
  def create_iterator
    raise NotImplementedError, "Subclasses must implement the 'create_iterator' method"
  end
end

# Concrete aggregate
class ShoppingCart < Collection
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def create_iterator
    ShoppingCartIterator.new(@items)
  end
end

# Iterator interface
class Iterator
  def has_next?
    raise NotImplementedError, "Subclasses must implement the 'has_next?' method"
  end

  def next_item
    raise NotImplementedError, "Subclasses must implement the 'next_item' method"
  end
end

# Concrete iterator
class ShoppingCartIterator < Iterator
  def initialize(items)
    @items = items
    @current_index = 0
  end

  def has_next?
    @current_index < @items.length
  end

  def next_item
    item = @items[@current_index]
    @current_index += 1
    item
  end
end

cart = ShoppingCart.new
cart.add_item("Item 1")
cart.add_item("Item 2")
cart.add_item("Item 3")

iterator = cart.create_iterator
while iterator.has_next?
  puts iterator.next_item
end
