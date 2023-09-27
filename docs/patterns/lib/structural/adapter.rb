# Target interface
class EmailProvider
  def send_email(to, subject, body)
    raise NotImplementedError, "Subclasses must implement the send_email method"
  end
end

# Adaptee
class MessageProvider
  def send_message(to, message)
    puts "Sending message to #{to}: #{message}"
  end
end

# Adapter
class MessageAdapter < EmailProvider
  def initialize(message_provider)
    @message_provider = message_provider
  end

  def send_email(to, subject, body)
    message = "#{subject}\n#{body}"
    @message_provider.send_message(to, message)
  end
end

message_provider = MessageProvider.new
message_adapter = MessageAdapter.new(message_provider)
message_adapter.send_email("scott@foobar.com", "Meeting Reminder", "Don't forget the meeting at 2pm today.")
