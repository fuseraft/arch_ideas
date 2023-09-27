# Abstract class
class PaymentProcessor
  def process_payment(amount)
    validate(amount)
    perform_payment(amount)
    notify_user(amount)
  end

  # Abstract methods
  def validate(amount)
    raise NotImplementedError, "Subclasses must implement the 'validate' method"
  end

  def perform_payment(amount)
    raise NotImplementedError, "Subclasses must implement the 'perform_payment' method"
  end

  def notify_user(amount)
    puts "Payment of #{amount} processed successfully"
  end
end

# Concrete classes
class PaypalProcessor < PaymentProcessor
  def validate(amount)
    raise "Invalid amount" if amount <= 0
  end

  def perform_payment(amount)
    # Perform payment using the PayPal API
    # ...
    puts "Payment of #{amount} processed using PayPal"
  end
end

class StripeProcessor < PaymentProcessor
  def validate(amount)
    raise "Invalid amount" if amount <= 0
  end

  def perform_payment(amount)
    # Perform payment using the Stripe API
    # ...
    puts "Payment of #{amount} processed using Stripe"
  end
end

amount = 100

paypal_processor = PaypalProcessor.new
paypal_processor.process_payment(amount)

stripe_processor = StripeProcessor.new
stripe_processor.process_payment(amount)
