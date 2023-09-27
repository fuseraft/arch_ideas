# Define an event class
class AccountEvent
  attr_reader :event_type, :amount, :timestamp

  def initialize(event_type, amount)
    @event_type = event_type
    @amount = amount
    @timestamp = Time.now
  end
end

# Define an account class that uses event sourcing
class Account
  attr_reader :balance

  def initialize(events = [])
    @balance = 0
    @events = events
    replay_events
  end

  def deposit(amount)
    @events << AccountEvent.new(:deposit, amount)
    @balance += amount
  end

  def withdraw(amount)
    if @balance >= amount
      @events << AccountEvent.new(:withdrawal, amount)
      @balance -= amount
    else
      raise "Insufficient funds"
    end
  end

  private

  def replay_events
    @events.each do |event|
      case event.event_type
      when :deposit
        @balance += event.amount
      when :withdrawal
        @balance -= event.amount
      end
    end
  end
end

account = Account.new
account.deposit(100)
account.withdraw(50)
account.deposit(75)

puts account.balance  # Output: 125
