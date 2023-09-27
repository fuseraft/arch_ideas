# Context class
class EncryptionSystem
  attr_accessor :encryption_strategy

  def initialize(encryption_strategy)
    @encryption_strategy = encryption_strategy
  end

  def encrypt(message)
    @encryption_strategy.encrypt(message)
  end
end

# Strategy interface
class EncryptionStrategy
  def encrypt(message)
    raise NotImplementedError, "Subclasses must implement the 'encrypt' method"
  end
end

# Concrete strategies
class AesEncryptionStrategy < EncryptionStrategy
  def encrypt(message)
    # Encrypt the message using the AES encryption algorithm
    # ...
    puts "Message encrypted using AES: #{message}"
  end
end

class DesEncryptionStrategy < EncryptionStrategy
  def encrypt(message)
    # Encrypt the message using the DES encryption algorithm
    # ...
    puts "Message encrypted using DES: #{message}"
  end
end

message = "This is a secret message"

encryption_system = EncryptionSystem.new(AesEncryptionStrategy.new)
encryption_system.encrypt(message)  # Output: "Message encrypted using AES: This is a secret message"

encryption_system.encryption_strategy = DesEncryptionStrategy.new
encryption_system.encrypt(message)  # Output: "Message encrypted using DES: This is a secret message"
