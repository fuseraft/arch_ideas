# Product
class Message
  attr_accessor :subject, :body, :sender, :recipient

  def to_s
    "From: #{sender}\nTo: #{recipient}\nSubject: #{subject}\n\n#{body}"
  end
end

# Abstract Builder
class MessageBuilder
  def build_subject; end
  def build_body; end
  def build_sender; end
  def build_recipient; end
  def get_result; end
end

# Concrete Builders
class EmailMessageBuilder < MessageBuilder
  def initialize
    @message = Message.new
  end

  def build_subject(subject = "Email Subject")
    @message.subject = subject
  end

  def build_body(body = "This is an email message.")
    @message.body = body
  end

  def build_sender(sender = "scott@foobar.com")
    @message.sender = sender
  end

  def build_recipient(recipient = "scott@foobar.com")
    @message.recipient = recipient
  end

  def get_result
    @message
  end
end

class SmsMessageBuilder < MessageBuilder
  def initialize
    @message = Message.new
  end

  def build_subject(subject = "SMS Subject")
    @message.subject = subject
  end

  def build_body(body = "This is an SMS message.")
    @message.body = body
  end

  def build_sender(sender = "+1234567890")
    @message.sender = sender
  end

  def build_recipient(recipient = "+0987654321")
    @message.recipient = recipient
  end

  def get_result
    @message
  end
end

# Director
class MessageDirector
  def initialize(builder)
    @builder = builder
  end

  def construct
    @builder.get_result
  end
end

email_builder = EmailMessageBuilder.new

email_builder.build_sender "scott@foobar.com"
email_builder.build_recipient "scott@foobar.com"
email_builder.build_body "This is an email built using the builder pattern."
email_builder.build_subject "Hello from builder.rb"

email_director = MessageDirector.new(email_builder)

email_message = email_director.construct

puts email_message  # From: scott@foobar.com
                    # To: scott@foobar.com
                    # Subject: Hello from builder.rb
                    #
                    # This is an email built using the builder pattern.
