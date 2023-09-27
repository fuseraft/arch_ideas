# Context class
class Context
  attr_accessor :variables

  def initialize
    @variables = {}
  end
end

# Abstract expression
class Expression
  def evaluate(context)
    raise NotImplementedError, "Subclasses must implement the 'evaluate' method"
  end
end

# Terminal expression
class VariableExpression < Expression
  def initialize(name)
    @name = name
  end

  def evaluate(context)
    context.variables[@name]
  end
end

# Nonterminal expression
class AddExpression < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def evaluate(context)
    @left.evaluate(context) + @right.evaluate(context)
  end
end

# Nonterminal expression
class SubtractExpression < Expression
  def initialize(left, right)
    @left = left
    @right = right
  end

  def evaluate(context)
    @left.evaluate(context) - @right.evaluate(context)
  end
end

context = Context.new
context.variables["x"] = 10
context.variables["y"] = 5

expression1 = SubtractExpression.new(VariableExpression.new("x"), VariableExpression.new("y"))
expression2 = AddExpression.new(VariableExpression.new("x"), VariableExpression.new("y"))

puts expression1.evaluate(context)   # 5
puts expression2.evaluate(context)   # 15
