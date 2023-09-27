# Subsystem classes
class Bank
  def initialize(name)
    @name = name
  end

  def get_balance(account_number)
    # Connect to the bank's database and get the balance of the specified account
    # For simplicity, we'll just return a hardcoded value
    return 1000.00
  end
end

class CreditCard
  def initialize(name)
    @name = name
  end

  def make_payment(amount)
    # Connect to the credit card company's database and make a payment on the account
    # For simplicity, we'll just print a message indicating that the payment was successful
    puts "Successfully made a payment of $#{amount} on #{@name} credit card."
  end
end

# Facade class
class FinancialServiceFacade
  def initialize
    @bank = Bank.new("My Bank")
    @credit_card = CreditCard.new("My Credit Card")
  end

  def check_balance(account_number)
    balance = @bank.get_balance(account_number)
    puts "Your current account balance is $#{balance}."
  end

  def make_payment(amount)
    @credit_card.make_payment(amount)
  end
end

financial_service = FinancialServiceFacade.new

financial_service.check_balance(1234567890)
financial_service.make_payment(100.00)
