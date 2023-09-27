# Handler interface
class Validator
  attr_accessor :successor

  def validate(input)
    raise NotImplementedError, "Subclasses must implement the 'validate' method"
  end

  protected

  def validate_next(input)
    if successor
      successor.validate(input)
    else
      true
    end
  end
end

# Concrete handler 1
class NotEmptyValidator < Validator
  def validate(input)
    if input.nil? || (input.is_a?(String) && input.empty?)
      false
    else
      validate_next(input)
    end
  end
end

# Concrete handler 2
class NumericValidator < Validator
  def validate(input)
    if input.is_a?(Numeric)
      validate_next(input)
    else
      false
    end
  end
end

# Concrete handler 3
class RangeValidator < Validator
  def initialize(min, max)
    @min = min
    @max = max
  end

  def validate(input)
    if input.respond_to?(:>=) && input.respond_to?(:<=) && input >= @min && input <= @max
      validate_next(input)
    else
      false
    end
  end
end

validator1 = NotEmptyValidator.new
validator2 = NumericValidator.new
validator3 = RangeValidator.new(1, 100)

validator1.successor = validator2
validator2.successor = validator3

puts validator1.validate("")       # false
puts validator1.validate(nil)      # false
puts validator1.validate("foo")    # true
puts validator1.validate(42)       # false
puts validator1.validate(0.5)      # false
puts validator1.validate(101)      # false
puts validator1.validate(50)       # true
