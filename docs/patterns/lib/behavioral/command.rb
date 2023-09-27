# Command interface
class Command
  def execute
    raise NotImplementedError, "Subclasses must implement the 'execute' method"
  end
end

# Concrete command 1
class EmailNotificationCommand < Command
  def initialize(email, message)
    @email = email
    @message = message
  end

  def execute
    # Code to send an email notification using the provided email address and message
    puts "Email sent to #{@email}"
  end
end

# Concrete command 2
class SmsNotificationCommand < Command
  def initialize(phone_number, message)
    @phone_number = phone_number
    @message = message
  end

  def execute
    # Code to send an SMS notification using the provided phone number and message
    puts "SMS sent to #{@phone_number}"
  end
end

# Invoker
class NotificationService
  def initialize
    @commands = []
  end

  def add_command(command)
    @commands << command
  end

  def run_commands
    @commands.each(&:execute)
  end
end

email_command = EmailNotificationCommand.new("scott@foobar.com", "Hello, world!")
sms_command = SmsNotificationCommand.new("123-456-7890", "Hello, world!")

service = NotificationService.new
service.add_command(email_command)
service.add_command(sms_command)
service.run_commands
