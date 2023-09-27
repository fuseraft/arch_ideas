# Mediator interface
class Chatroom
  def send_message(message, sender)
    raise NotImplementedError, "Subclasses must implement the 'send_message' method"
  end
end

# Concrete mediator
class ChatroomImpl < Chatroom
  def initialize
    @users = {}
  end

  def register(user)
    @users[user.name] = user
    user.chatroom = self
  end

  def send_message(message, sender)
    @users.each do |name, user|
      next if user == sender
      user.receive_message(message, sender.name)
    end
  end
end

# Colleague interface
class User
  attr_accessor :chatroom, :name

  def initialize(name)
    @name = name
  end

  def send_message(message)
    @chatroom.send_message(message, self)
  end

  def receive_message(message, sender_name)
    puts "#{sender_name} sent the following message to #{@name}: #{message}"
  end
end

chatroom = ChatroomImpl.new

alice = User.new("Alice")
bob = User.new("Bob")
charlie = User.new("Charlie")

chatroom.register(alice)
chatroom.register(bob)
chatroom.register(charlie)

alice.send_message("Hello, everyone!")
bob.send_message("Hi, Alice and Charlie!")
charlie.send_message("Hey there, everyone.")
