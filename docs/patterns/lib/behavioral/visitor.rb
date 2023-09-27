# Element interface
class BankAccount
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def accept(visitor)
    visitor.(self)
  end
end

# Concrete elements
class SavingsAccount < BankAccount
end

class CheckingAccount < BankAccount
end

# Visitor interface
class BankAccountVisitor
  def call(account)
    raise NotImplementedError, "Subclasses must implement the 'call' method"
  end
end

# Concrete visitors
class MonthlyInterestVisitor < BankAccountVisitor
  def call(account)
    interest_rate = 0.01
    interest = account.balance * interest_rate / 12
    puts "Monthly interest for #{account.class.name} account: $#{interest.round(2)}"
  end
end

class AccountStatusVisitor < BankAccountVisitor
  def call(account)
    if account.balance < 0
      puts "#{account.class.name} account is overdrawn"
    else
      puts "#{account.class.name} account is in good standing"
    end
  end
end

savings_account = SavingsAccount.new(1000)
checking_account = CheckingAccount.new(-100)

monthly_interest_visitor = MonthlyInterestVisitor.new
account_status_visitor = AccountStatusVisitor.new

savings_account.accept(monthly_interest_visitor)  # Output: "Monthly interest for SavingsAccount account: $8.33"
savings_account.accept(account_status_visitor)  # Output: "SavingsAccount account is in good standing"

checking_account.accept(monthly_interest_visitor)  # Output: "Monthly interest for CheckingAccount account: $-0.83"
checking_account.accept(account_status_visitor)  # Output: "CheckingAccount account is overdrawn"
